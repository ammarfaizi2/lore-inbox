Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266743AbRGFP6M>; Fri, 6 Jul 2001 11:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266747AbRGFP6B>; Fri, 6 Jul 2001 11:58:01 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:7397 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S266746AbRGFP5r>; Fri, 6 Jul 2001 11:57:47 -0400
Message-ID: <71714C04806CD511935200902728921702E5FB@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: jgarzik@mandrakesoft.com, sp@scali.no
Cc: alan@lxorguk.ukuu.org.uk, helgehaf@idb.hist.no,
        pvvvarma@techmas.hcltech.com, linux-kernel@vger.kernel.org,
        davem@redhat.com, linux-ia64@linuxia64.org
Subject: RE: DMA memory limitation?
Date: Fri, 6 Jul 2001 10:56:47 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The important thing is that pci_alloc_consistent and the other PCI DMA
> functions work as advertised on IA64.  If you pass NULL to
> pci_alloc_consistent, IA64 should give you an ISA DMA-able 
> address.  If
> you don't, you get a 32-bit PCI DMA address.  Use of GFP_DMA is a
> arch-specific detail, so don't let me confuse you there.

Until recently, on IA-64, pci_alloc_consistent() given a NULL pci_dev would
fault.  It's been fixed in at least the most recent IA-64 patch.
pci_map_single() and pci_map_sg() still have the same problem, as they
dereference pci_dev w/o checking for NULL first.


-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!

