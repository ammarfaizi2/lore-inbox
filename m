Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUESDfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUESDfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 23:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbUESDfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 23:35:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:12509 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263781AbUESDfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 23:35:18 -0400
Date: Tue, 18 May 2004 20:34:39 -0700
From: Greg KH <greg@kroah.com>
To: John Zielinski <grim@undead.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] sysfs kobject that doesn't trigger hotplug events
Message-ID: <20040519033439.GA8160@kroah.com>
References: <40AAC26C.2080803@undead.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AAC26C.2080803@undead.cc>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 10:11:56PM -0400, John Zielinski wrote:
> 
> Looking through the kobject.c code I noticed that this would create a 
> lot of hotplug events which would burn up a bit of processor time.  
> These events are not necessary as these are not device kobjects.  I've 
> enclosed a patch to my solution for this.  I'd like to know if there are 
> any side effects with this method.

Your patch is not needed at all.  Please read the first comment in the
kobject_hotplug() function to see how to prevent kobjects from creating
hotplug events.

thanks,

greg k-h
