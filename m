Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSKNDSE>; Wed, 13 Nov 2002 22:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSKNDSD>; Wed, 13 Nov 2002 22:18:03 -0500
Received: from dp.samba.org ([66.70.73.150]:1721 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261321AbSKNDSD>;
	Wed, 13 Nov 2002 22:18:03 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug 
In-reply-to: Your message of "Wed, 13 Nov 2002 12:11:01 -0800."
             <3DD2B1D5.7020903@pacbell.net> 
Date: Thu, 14 Nov 2002 14:46:51 +1100
Message-Id: <20021114032456.46D742C09E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DD2B1D5.7020903@pacbell.net> you write:
> The module-init-tools-0.6.tar.gz utilities (or something
> related -- kbuild changes?) break hotplug since they no
> longer produce the /lib/modules/$(uname -r)/modules.*map
> files as output ... so the hotplug agents don't have the
> pre-built database mapping device info to drivers.

Sorry, I've been feeding Linus (and lkml) slowly.  It's not permenant,
I promise 8) I discussed the issue with Greg Kroah-Hartman and have
sent him a patch for examination.  In the new method, external code
doesn't know about kernel datastructures.

> What's the plan for getting that back?  (And module.conf
> params etc.)

The question is whether to force an /sbin/hotplug change to use the
module alias mechanism, or generate the modules.*map files at "make
modules_install" time to avoid breakage.  I'm leaning towards #2, but
I haven't written it yet (should be simple).

0.7 has preliminary /etc/modprobe.conf support, but it only does
primitive aliases not options as yet.  That's next on my list for
userspace, along with "modprobe -r".

> "Changes" says version 2.4.2 is fine, which appears to be wrong...

Thanks for the feedback,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
