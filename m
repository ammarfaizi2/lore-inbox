Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVAGXp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVAGXp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVAGXnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:43:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56059 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261715AbVAGXgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:36:40 -0500
Date: Fri, 7 Jan 2005 15:36:32 -0800
From: Greg KH <greg@kroah.com>
To: Ikke <ikke.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kobject_uevent
Message-ID: <20050107233632.GA1467@kroah.com>
References: <297f4e01050107065060e0b2ad@mail.gmail.com> <297f4e0105010713254b6e0678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297f4e0105010713254b6e0678@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:25:14PM +0100, Ikke wrote:
> I'm a little confused by the use of KOBJ_* stuff in
> include/linux/kobject_uevent.h and the string representation of them
> in lib/kobject_uevent.c, which means people must edit 2 files if they
> want to add new events?

Yes, that is exactly correct.  The enumerated type is used for the
callers to kobject_uevent* and the string is sent out on the wire from
within the kevent core code.

Hope this helps,

greg k-h
