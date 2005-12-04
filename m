Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbVLDQW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbVLDQW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVLDQW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:22:56 -0500
Received: from hornet.berlios.de ([195.37.77.140]:12819 "EHLO
	hornet.berlios.de") by vger.kernel.org with ESMTP id S932269AbVLDQWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:22:55 -0500
From: Michael Frank <mhf@users.berlios.de>
Reply-To: mhf@users.berlios.de
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Golden rule: don't break userland (was Re: RFC: Starting a stable kernel series off the 2.6 kernel)
Date: Sun, 4 Dec 2005 16:37:39 +0100
Cc: Adrian Bunk <bunk@stusta.de>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>
References: <20051203135608.GJ31395@stusta.de> <20051203152339.GK31395@stusta.de> <4391E764.7050704@pobox.com>
In-Reply-To: <4391E764.7050704@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <20051204162404.1D26B2947@hornet.berlios.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 19:43, Jeff Garzik wrote:
> Adrian Bunk wrote:
> > IOW, we should e.g. ensure that today's udev will still
> > work flawlessly with kernel 2.6.30 (sic)?
> >
> > This could work, but it should be officially announced
> > that e.g. a userspace running kernel 2.6.15 must work
> > flawlessly with _any_ future 2.6 kernel.
>
> Fix the real problem:  publicly shame kernel hackers that
> change userland ABI/API without LOTS of notice, and
> hopefully an old-userland compatibility solution
> implemented.
>
> We change kernel APIs all the time.  Having made that
> policy decision, we have the freedom to rapidly improve
> the kernel, and avoid being stuck with poor designs of
> the past.
>
> Userland isn't the same.  IMO sysfs hackers have
> forgotten this. Anytime you change or remove sysfs
> attributes these days, you have the potential to break
> userland, which breaks one of the grand axioms of Linux. 
> Everybody knows "the rules" when it comes to removing
> system calls, but forgets/ignores them when it comes to
> ioctls, sysfs attributes, and the like.

WRT sysfs, sysfs is dynamic by design to accommodate 
individual HW configuration. Thus isn't this really a fault 
of user-space implementation?

>
> Thus, I've often felt that heavy sysfs (and procfs) use
> made it too easy to break userland.  Maybe we should
> change the sysfs API to include some sort of interface
> versioning, or otherwise make it more obvious to the
> programmer that they could be breaking userland compat.

You might need versions for every entry. I'd go for more 
documentation on proper use.

>
> Offhand, once implemented and out in the field, I would
> say a userland interface should live at least 1-2 years
> after the "we are removing this interface" warning is
> given.
>
> Yes, 1-2 years.  Maybe even that is too small.  We still
> have old_mmap syscall around :)
>
> 	Jeff
>

