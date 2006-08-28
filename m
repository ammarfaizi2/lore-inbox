Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWH1JH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWH1JH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 05:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWH1JH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 05:07:56 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:63148 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S932117AbWH1JH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 05:07:56 -0400
Date: Mon, 28 Aug 2006 10:07:54 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3
Message-ID: <20060828090754.GA21146@skynet.ie>
References: <20060826160922.3324a707.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060826160922.3324a707.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: mel@skynet.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On (26/08/06 16:09), Andrew Morton didst pronounce:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/
> 

This failed to build on two x86_64 machines I have access to with (one
on test.kernel.org);

  OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
  BFD: Warning: Writing section `.data.percpu' to huge (ie negative)
  file offset 0x80471000.
  /usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy:
  arch/x86_64/boot/compressed/vmlinux.bin: File truncated
  make[2]: *** [arch/x86_64/boot/compressed/vmlinux.bin] Error 1
  make[1]: *** [arch/x86_64/boot/compressed/vmlinux] Error 2
  make: *** [bzImage] Error 2
  08/26/06-17:16:14 Build the kernel. Failed rc = 2
  08/26/06-17:16:14 build: kernel build Failed rc = 1
  08/26/06-17:16:14 command complete: (2) rc=126
  Failed and terminated the run
   Fatal error, aborting autorun

CONFIG_NR_CPUS was 8. The build log can be seen at
http://test.kernel.org/abat/45342/debug/test.log.0 and the .config is at
http://test.kernel.org/abat/45342/build/dotconfig . I haven't done any
further investigation in case this is a known problem. If it's new, I'll
start digging.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
