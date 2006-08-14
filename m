Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbWHNAfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbWHNAfa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWHNAfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 20:35:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751761AbWHNAf3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 20:35:29 -0400
Date: Sun, 13 Aug 2006 17:35:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend
Message-Id: <20060813173503.e009583c.akpm@osdl.org>
In-Reply-To: <17002.1155514915@ocs10w.ocs.com.au>
References: <200608130456_MC3-1-C7EE-44C8@compuserve.com>
	<17002.1155514915@ocs10w.ocs.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 10:21:55 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> ksymoops -VKLMO -t elf64-x86-64 -a i386:x86-64

box:/home/akpm> ksymoops -VKLMO -t elf64-x86-64 -a i386:x86-64 < x
ksymoops 2.4.11 on x86_64 2.6.17-rc5.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -M (specified)
     -t elf64-x86-64 -a i386:x86-64

Warning (merge_maps): no symbols in merged map
CPU 0
...
 [<ffffffff80471e5b>] _spin_unlock_irq+0x2b/0x60
 [<ffffffff8020a2c0>] restore_args+0x0/0x30
 [<ffffffff80243620>] kthread+0x0/0x110
 [<ffffffff8020a6fe>] child_rip+0x0/0x12
Code: 44 8b 28 c7 45 d0 00 00 00 00 45 85 ed 0f 89 29 fb ff ff e9
Error (Oops_bfd_perror): /tmp/ksymoops.0lrVNY Invalid bfd target

box:/home/akpm> rpm -qi ksymoops 
Name        : ksymoops                     Relocations: (not relocatable)
Version     : 2.4.11                            Vendor: (none)
Release     : 1                             Build Date: Sat Jan  8 05:43:45 2005
Install Date: Wed Jun 28 16:59:45 2006      Build Host: ocs3.ocs.com.au
Group       : Utilities/System              Source RPM: ksymoops-2.4.11-1.src.rpm
Size        : 542288                           License: GPL
Signature   : (none)
Summary     : Kernel oops and error message decoder
Description :
The Linux kernel produces error messages that contain machine specific
numbers which are meaningless for debugging.  ksymoops reads machine
specific files and the error log and converts the addresses to
meaningful symbols and offsets.

