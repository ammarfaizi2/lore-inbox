Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289106AbSA1DvN>; Sun, 27 Jan 2002 22:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289107AbSA1DvC>; Sun, 27 Jan 2002 22:51:02 -0500
Received: from ausxc08.us.dell.com ([143.166.227.176]:50954 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S289106AbSA1Duu>; Sun, 27 Jan 2002 22:50:50 -0500
Message-ID: <71714C04806CD5119352009027289217022C42DD@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: brownfld@irridia.com, ivan@es.usyd.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: RE: Physical memory versus detected memory 2.4.7-10
Date: Sun, 27 Jan 2002 21:50:42 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | My server detects less memory than it available. 
> | 
> | 	Available memory according to the BIOS 4049MB.
> | 
> | 	System sees only 3.7GB ???
> | 	Mem:  3799580K av, 1606816K used, 2192764K free, 468K shrd, 376972K
buff
> | 	Swap: 8192992K av, 0K used, 8192992K free 1037532K cached

The difference is space assigned to PCI cards or reserved for hot-plug PCI
cards.  You should be able to run a CONFIG_HIGHMEM64G-enabled kernel (such
as the Red Hat 2.4.x-enterprise kernels instead of the -smp kernel) and be
able to use the remaining memory, at the performance cost of enabling PAE.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.5% (IDC Dec 2001)
