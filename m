Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTDOSZB (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbTDOSZB 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:25:01 -0400
Received: from siaag2ad.compuserve.com ([149.174.40.134]:6334 "EHLO
	siaag2ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262894AbTDOSY7 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:24:59 -0400
Date: Tue, 15 Apr 2003 14:33:51 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Problem: 2.4.20, 2.5.66 have different IDE channel order
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304151436_MC3-1-3487-2162@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For compiled in IDE the order is defined by the order on the PCI
> bus scan, not by the IDE layer
>
> (See ide/setup-pci.c:ide_scan_pcibus)


  Well, that matches what 2.4 does:


00:0d.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
01:0b.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)


  2.5 nonmodular seems to be doing it in BIOS order  -- the HPT370 BIOS
initializes before the Promise (and won't let it boot but I can deal
with that.)  I'll probably replace it with a PDC20262 before looking
at any code...

--
 Chuck
