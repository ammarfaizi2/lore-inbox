Return-Path: <linux-kernel-owner+w=401wt.eu-S1754519AbWLRULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbWLRULn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbWLRULn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:11:43 -0500
Received: from mail.kroah.org ([69.55.234.183]:40629 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754519AbWLRULm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:11:42 -0500
X-Greylist: delayed 1074 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 15:11:42 EST
Date: Mon, 18 Dec 2006 11:51:15 -0800
From: Greg KH <greg@kroah.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, kay.sievers@vrfy.org
Subject: Re: kobject.h with HOTPLUG=n
Message-ID: <20061218195115.GA11312@kroah.com>
References: <4586D4A4.5060309@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4586D4A4.5060309@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 09:49:24AM -0800, Randy Dunlap wrote:
> In 2.6.20-rc1-mm1, with HOTPLUG=n, 2 linux/kobject.h inline functions
> need to return <int>.  Currently this causes 962 warnings like this:
> 
> include/linux/kobject.h: In function 'kobject_uevent':
> include/linux/kobject.h:277: warning: no return statement in function 
> returning non-void
> include/linux/kobject.h: In function 'kobject_uevent_env':
> include/linux/kobject.h:281: warning: no return statement in function 
> returning non-void
> 
> Should these functions return 0 or some error code?
> 
> static inline int kobject_uevent(struct kobject *kobj, enum kobject_action 
> action) { }
> static inline int kobject_uevent_env(struct kobject *kobj,
> 				      enum kobject_action action,
> 				      char *envp[])
> { }

They should just return 0.  Care to make up a quick patch to fix this?

thanks,

greg k-h
