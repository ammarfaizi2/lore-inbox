Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVFCRnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVFCRnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVFCRnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:43:22 -0400
Received: from webmail.topspin.com ([12.162.17.3]:10435 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261420AbVFCRmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:42:51 -0400
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: ppc64 dev list <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc5-git8 regression on PPC64
X-Message-Flag: Warning: May contain useful information
References: <374360000.1117810369@[10.10.2.4]>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Jun 2005 10:42:46 -0700
In-Reply-To: <374360000.1117810369@[10.10.2.4]> (Martin J. Bligh's message
 of "Fri, 03 Jun 2005 07:52:49 -0700")
Message-ID: <52is0vwd49.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Jun 2005 17:42:46.0871 (UTC) FILETIME=[A75A9670:01C56863]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing something possibly related as well -- with an up-to-date
git tree (HEAD == d8d088d25822b0199fdfb392085e1cf8a5914a97), I get a
hang early in the boot on an OpenPower 710 (2 x POWER5).  It seems to
get just a little further:


Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 02300000, size: 949 Kbytes
OF stdout device is: /vdevice/vty@30000000
command line: ro console=hvsi0 root=/dev/sdd5
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000023ee000
  alloc_top    : 0000000040000000
  alloc_top_hi : 00000001e8000000
  rmo_top      : 0000000040000000
  ram_top      : 00000001e8000000
Looking for displays
found display   : /pci@800000020000003/pci@2,2/pci@1/display@0, opening ... done
instantiating rtas at 0x00000000077ca000 ... done
0000000000000000 : boot cpu     0000000000000000
0000000000000002 : starting cpu hw idx 0000000000000002... done
copying OF device tree ...
Building dt strings...
Building dt structure...
Device tree strings 0x00000000027ef000 -> 0x00000000027f02f8
Device tree struct  0x00000000027f1000 -> 0x0000000002809000


and that's the last thing I see.

 - R.
