Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTEMTzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTEMTzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:55:16 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:1517 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S262458AbTEMTzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:55:15 -0400
Date: Tue, 13 May 2003 16:04:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6 must-fix list, v2
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <200305131607_MC3-1-38BA-B475@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > - 2.5.x won't boot on some 440GX
>
> Problem understood now, feasible fix in 2.4/2.4-ac. (440GX has two IRQ
> routers, we use the $PIR table with the PIIX, but the 440GX doesnt use
> the PIIX for its IRQ routing). Fall back to BIOS for 440GX works and
> Intel concurs.


  With 2.5.69, 2.4.20 and 2.4.21-rc2-ac1 on Dell Workstation 610
(440GX) I see:

     PCI: Using configuration type 1
     ...
     PCI: Using IRQ router PIIX [8086/7110] at 00:07.0


  lspci says it's an 82443GX.  Why does this one work when others are
broken?
