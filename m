Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267370AbTACAvO>; Thu, 2 Jan 2003 19:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbTACAvO>; Thu, 2 Jan 2003 19:51:14 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:35766 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S267370AbTACAvN>; Thu, 2 Jan 2003 19:51:13 -0500
From: Erik Hensema <usenet@hensema.xs4all.nl>
Subject: Re: kernel .config support?
Date: Fri, 3 Jan 2003 00:59:41 +0000 (UTC)
Message-ID: <slrnb19o3t.1ki.usenet@bender.home.hensema.net>
References: <Pine.LNX.4.44.0301020930510.7804-100000@dell>
Reply-To: erik@hensema.xs4all.nl
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day (rpjday@mindspring.com) wrote:
> 
>   whatever happened to that funky option from 2.4 --
> for kernel .config support, which allegedly buried the
> config file inside the kernel itself.  (it never worked --
> the alleged extraction script scripts/extract-ikconfig
> depended on a program called "binoffset" that didn't 
> exist in that distribution.)
> 
>   any plans to resurrect this, or something like it?

It's never been part of the standard kernel distribution. Your distribution
probably has an extra patch compiled in in order to provide this.

It's IMO not very usefull: each distribution of a compiled kernel should
just include a seperate file containing the .config, just like it contains
seperate modules. The prefered name is $IMAGENAME.config, where $IMAGENAME
is the name of the installed kernel image. No need to bloat the kernel with
this information, IMHO.

I'd love to see a patch which copies the .config to /vmlinuz.config on a
standard make {zlilo|bzlilo|install} though.

(yes, I know that the .config won't be available on a bootfloppy without a
fs. Then again, on a bootfloppy /with/ fs, there won't be space for a
.config...)
-- 
Erik Hensema <erik@hensema.net>
