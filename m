Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130763AbRAKKYY>; Thu, 11 Jan 2001 05:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130767AbRAKKYO>; Thu, 11 Jan 2001 05:24:14 -0500
Received: from enterprise.cistron.net ([195.64.68.33]:41487 "EHLO
	enterprise.cistron.net") by vger.kernel.org with ESMTP
	id <S130763AbRAKKYI>; Thu, 11 Jan 2001 05:24:08 -0500
From: dth@lin-gen.com (Danny ter Haar)
Subject: Re: Drivers under 2.4
Date: Thu, 11 Jan 2001 10:24:01 +0000 (UTC)
Organization: Linux Generation bv
Message-ID: <93k1k0$87v$1@voyager.cistron.net>
In-Reply-To: <20010110223836.A7321@gruyere.muc.suse.de> <Pine.LNX.4.30.0101110003020.30013-100000@prime.sun.ac.za>
Reply-To: dth@lin-gen.com
X-Trace: voyager.cistron.net 979208641 8447 195.64.80.162 (11 Jan 2001 10:24:01 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Grobler  <grobh@sun.ac.za> wrote:
>The softnet changes are most likely the primary source of breakage (for
>network drivers).

I happen to have a multimedia box from siemens/fujitsu with a 
cyrix processor, chipset and amd/lance ethernet chipset onboard.
It' working fine with 2.2.x but not with 2.4.x kernels with 
the same driver version of the pcnet32 networkdriver.

2.4.0-ac4

Jan  9 17:09:53 multimedia kernel: Linux version 2.4.0-ac4 (root@ws1) (gcc version 2.95.3 20001229 (prerelease)) #2 Tue Jan 9 16:22:08 CET 2001
Jan  9 17:09:53 multimedia kernel: PCI: Found IRQ 9 for device 00:0f.0
Jan  9 17:09:53 multimedia kernel: eth0: PCnet/FAST III 79C973 at 0xfce0, 00 00 e2 24 41 1d
Jan  9 17:09:53 multimedia kernel: pcnet32: pcnet32_private lp=c3c80000 lp_dma_addr=0x3c80000 assigned IRQ 9.
Jan  9 17:09:53 multimedia kernel: pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de


and 2.2.19pre7

Jan 10 20:46:15 multimedia kernel: Linux version 2.2.19pre7 (root@multimedia) (gcc version 2.95.3 20001229 (prerelease)) #2 Wed Jan 10 20:13:57 CET 2001
Jan 10 20:46:15 multimedia kernel: pcnet32.c: PCI bios is present, checking for devices...
Jan 10 20:46:15 multimedia kernel: Found PCnet/PCI at 0xfce0, irq 9.
Jan 10 20:46:15 multimedia kernel: eth0: PCnet/FAST III 79C973 at 0xfce0, 00 00 e2 24 41 1d assigned IRQ 9.
Jan 10 20:46:15 multimedia kernel: pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de

Version number of the driver is the same but it doesn't work.

Any thoughts anyone ?

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
