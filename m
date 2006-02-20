Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWBTMkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWBTMkL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 07:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWBTMkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 07:40:11 -0500
Received: from tornado.reub.net ([202.89.145.182]:54503 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030191AbWBTMkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 07:40:10 -0500
Message-ID: <43F9B8A9.4000506@reub.net>
Date: Tue, 21 Feb 2006 01:40:09 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060213)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc4-mm1
References: <20060220042615.5af1bddc.akpm@osdl.org>
In-Reply-To: <20060220042615.5af1bddc.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/02/2006 1:26 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc4/2.6.16-rc4-mm1/
> 
> - git-jfs.patch has been dropped due to its ongoing git problems.
> 
> - Added Al Viro's `bird' tree (what does that mean, anyway?) as
>   git-viro-bird.patch.
> 
>   This tree had a lot of things dropped when it is merged into -mm, partly
>   because some of it appears to have been merged into other git trees.
> 
> - This kernel won't compile on ia64 (and possibly other architectures)
>   because the kbuild tree is using Elf_Rela in scripts/mod/modpost.c.  Is OK
>   on x86, x86_64 and powerpc.  Sam might send a hotfix?
> 
> - Many warnings are emitted at the link stage due to section mismatches and
>   duplicated symbol exports.  Please don't report these.  Patches are welcome,
>   but do them carefully - it's easy to make mistakes with these things.

Time for the brown paper bag............ ;)

[root@tornado linux-2.6-mm]# make
/usr/src/linux/linux-2.6-mm/scripts/gcc-version.sh: line 11: ccache: command not 
found
/usr/src/linux/linux-2.6-mm/scripts/gcc-version.sh: line 12: ccache: command not 
found
make: ccache: Command not found
   CHK     include/linux/version.h
   CC      arch/i386/kernel/asm-offsets.s
/bin/sh: ccache: command not found
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 127
make: *** [prepare0] Error 2
[root@tornado linux-2.6-mm]#

Removing 'ccache' from the CC line in Makefile fixed this.

reuben
