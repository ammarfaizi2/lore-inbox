Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTDOAnN (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 20:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264020AbTDOAnN (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 20:43:13 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:38848 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264018AbTDOAnM (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 20:43:12 -0400
Date: Mon, 14 Apr 2003 20:51:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Problem: 2.4.20, 2.5.66 have different IDE channel order
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304142054_MC3-1-3463-6D74@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I just added an HPT370A IDE controller to this machine:


00:00.0 Host bridge: Intel Corp. 440FX - 82441FX PMC [Natoma] (rev 02)
00:0d.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:0d.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
00:0e.0 PCI bridge: Digital Equipment Corporation DECchip 21052 (rev 01)
00:10.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev 02)
00:11.0 VGA compatible controller: Silicon Integrated Systems [SiS] 86C326 (rev 0b)
01:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
01:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
01:0b.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 / HPT370 (rev 03)



  2.4 (RH 7.3 rescue mode and 2.4.20 non-modular) sees this order:

    PIIX3, PDC20268, HPT370

  2.5 sees this:

    PIIX3, HPT370, PDC20268

  Obviously reversing order isn't going to help here.

  I edited the Makefile to change the link order but that didn't help.


--
 Chuck
