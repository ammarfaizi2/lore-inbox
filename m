Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbTDNKvl (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 06:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbTDNKvl (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 06:51:41 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:9867 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP id S262785AbTDNKvk (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 06:51:40 -0400
Date: Mon, 14 Apr 2003 04:03:26 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.67-mm3
Message-ID: <20030414110326.GA19003@gnuppy.monkey.org>
References: <20030414015313.4f6333ad.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414015313.4f6333ad.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 01:53:13AM -0700, Andrew Morton wrote:
> A bunch of new fixes, and a framebuffer update.  This should work a bit
> better than -mm2.

make -f scripts/Makefile.build obj=arch/i386/boot arch/i386/boot/bzImage
  ld -m elf_i386  -Ttext 0x0 -s --oformat binary -e begtext
  arch/i386/boot/setup.o -o arch/i386/boot/setup 
  arch/i386/boot/setup.o(.text+0x9a4): In function `video':
  /tmp/ccyhvWWu.s:2925: undefined reference to `store_edid'
  make[1]: *** [arch/i386/boot/setup] Error 1
  make: *** [bzImage] Error 2

---------------------------------------

Not sure what's triggering this here.

bill

