Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbRDVCUY>; Sat, 21 Apr 2001 22:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135171AbRDVCUO>; Sat, 21 Apr 2001 22:20:14 -0400
Received: from leng.mclure.org ([64.81.48.142]:54546 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S135170AbRDVCT7>; Sat, 21 Apr 2001 22:19:59 -0400
Date: Sat, 21 Apr 2001 19:19:37 -0700
From: Manuel McLure <manuel@mclure.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-ac10/ac11 crash at boot in PDC20265 check
Message-ID: <20010421191937.I1106@ulthar.internal.mclure.org>
In-Reply-To: <20010421183212.G1106@ulthar.internal.mclure.org> <E14r9Ck-0004nW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14r9Ck-0004nW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Apr 21, 2001 at 19:02:24 -0700
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.04.21 19:02 Alan Cox wrote:
> > Found promise 20265 in RAID mode." message. I diffed ide-pci.c between
> ac5
> > (which worked) and ac10 (which fails) and found that the only change
> was
> > the check for the PDC20265 - I commented this out and the kernel boots
> fine
> > now.
> 
> Can you send me the oops data. I'll take a look and figure out what is
> up.
> My first guess would be its a NULL pointer error ?

Yes, it's a NULL pointer dereference. I copied down part of the Oops - I'll
have to put the code back before I can copy down the rest. Here's what I
have until now:

Unable to handle kernel NULL pointer dereference at virtual address
00000024 printing eip:
c02a71de

pgd entry c0101000: 0000000000000000
pmd entry c0101000: 0000000000000000
.. pmd not present!
Oops: 0000
CPU:    0
EIP:    0010:[<c02a71de>]
EFLAGS: 00010286

According to System.map, c02a71de is in the middle of ide_setup_pci_device
which makes sense. ide_setup_pci_device starts at c02a7020.

-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

