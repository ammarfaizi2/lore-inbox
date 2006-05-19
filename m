Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWESUSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWESUSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWESUSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:18:42 -0400
Received: from xenotime.net ([66.160.160.81]:61611 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964813AbWESUSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:18:42 -0400
Date: Fri, 19 May 2006 13:21:08 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format?
Message-Id: <20060519132108.ab528a59.rdunlap@xenotime.net>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0012B3269@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B3269@chicken.machinevisionproducts.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006 11:38:23 -0700 Brian D. McGrew wrote:

> Seems my failure to post the complete set of files has caused great
> confusion.  Is that a sign of stress or frustration or both???  
> 
> Here is a complete listing of all the files, including the Makefile.  I
> think this is everything now.
> 
> I'm facing two problems.  First, the 2.6.16 kernel won't load this
> driver; throws an invalid module format as where 2.6.15 loads it just
> fine.
> 
> Secondly, the driver is supposed to allocate kernel memory that's
> accessable from userspace.  If you see the function
> alloc_ibb_user_shared(IbbSoftDev *) and the function
> alloc_ibb_image_table_mem(IbbSoftDev *, int); you'll see where I've a
> couple of attempts at calling __get_free_pages as well as a shot at
> vmalloc.  I've narrowed it down to this one section that's killing me.  
> 
> If anyone can offer help, that would be great because I'm just stuck on
> this and have been for six months!!!

Are you running the hardware/kernel in 32-bit mode?  or 64-bit?
(I don't know what a Dell PE1800 has/does.)
I'm guessing 32-bit due to all of the warnings I see in x86_64 mode.

The problem could be something as simple as the modules don't have
a MODULE_LICENSE() in them.  Are you running a RH/FC kernel or your
own custom kernel?  I get this when I load them:

ibb: module license 'unspecified' taints kernel.

I can load/unload both of them.

---
~Randy
