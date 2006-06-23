Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751272AbWFWPtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWFWPtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWFWPtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:49:03 -0400
Received: from mailgate1.uni-kl.de ([131.246.120.5]:11736 "EHLO
	mailgate1.uni-kl.de") by vger.kernel.org with ESMTP
	id S1751272AbWFWPtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:49:02 -0400
Date: Fri, 23 Jun 2006 17:48:58 +0200
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-ID: <20060623154858.GA15327@rotes76.wohnheim.uni-kl.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Andrew Morton [Wed, Jun 21 2006, 03:48:57AM]:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm1/

Cannot build it. Looks like the build system is looping over:

  GEN     usr/klibc/syscalls/typesize.c
  KLIBCCC usr/klibc/syscalls/typesize.o
  OBJCOPY usr/klibc/syscalls/typesize.bin
  GEN     usr/klibc/syscalls/syscalls.mk
  GEN     usr/klibc/syscalls/typesize.c
  KLIBCCC usr/klibc/syscalls/typesize.o
  OBJCOPY usr/klibc/syscalls/typesize.bin
  GEN     usr/klibc/syscalls/syscalls.mk
  GEN     usr/klibc/syscalls/typesize.c
  KLIBCCC usr/klibc/syscalls/typesize.o
  OBJCOPY usr/klibc/syscalls/typesize.bin
  GEN     usr/klibc/syscalls/syscalls.mk
  GEN     usr/klibc/syscalls/typesize.c
  KLIBCCC usr/klibc/syscalls/typesize.o
  OBJCOPY usr/klibc/syscalls/typesize.bin
  GEN     usr/klibc/syscalls/syscalls.mk

No matter whether executed as user or as root. Setting KBUILD_VERBOSE
does not help much, for the log see http://people.debian.org/~blade/log .

Eduard.



