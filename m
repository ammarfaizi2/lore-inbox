Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129887AbRBPJrt>; Fri, 16 Feb 2001 04:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBPJrk>; Fri, 16 Feb 2001 04:47:40 -0500
Received: from db0bm.automation.fh-aachen.de ([193.175.144.197]:19718 "EHLO
	db0bm.ampr.org") by vger.kernel.org with ESMTP id <S129887AbRBPJre>;
	Fri, 16 Feb 2001 04:47:34 -0500
Date: Fri, 16 Feb 2001 10:46:44 +0100
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200102160946.KAA08821@db0bm.ampr.org>
To: adam@yggdrasil.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.2-pre3/arch/i386/boot/Makefile breaks with binutils-2.10.1.0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The "ld" program in binutils-2.10.1.0.7 and in binutils-2.10.91.0.2 now 
> requires "--oformat" instead of "-oformat".
	
[root@debian-f5ibh] /usr/src/kernel-sources-2.4.2 # ld -v
GNU ld version 2.9.5 (with BFD 2.9.5.0.37)

[root@debian-f5ibh] /usr/src/kernel-sources-2.4.2 # ld --help
Usage: ld [options] file...
Options:
   -a KEYWORD                  Shared library control for HP/UX compatibility
   -A ARCH, --architecture ARCH
   ...

   --noinhibit-exec            Create an output file even if errors occur
   --oformat TARGET            Specify target of output file
   -qmagic                     Ignored for Linux compatibility
   ...

So it seems that this option appears before  binutils-2.10.1.0.7 and
binutils-2.10.91.0.2

The 2.4.2i-pre3 kernel minimal requirements are : 
o  binutils               2.9.1.0.25              # ld -v

It is the same for 2.4.1-ac15.

For 2.2.19-pre, the requirements are :
- Binutils               2.8.1.0.23              ; ld -v

I've not 2.8.1.0.23, s I don't know what is the option used.

I've compiled 2.4.2-pre, 2.4.1-acxx and 2.2.19-prexx with the same 'ls" program
without any adverse effect...

Maybe the best would be to apply the patch to 2.2.19pre, 2.4.x and ac releases.
This would allows havind only one "ld" on the system if using more than one
kernel.

----------
Regards

		Jean-Luc
