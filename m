Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUA3SME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbUA3SME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:12:04 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:45734 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262888AbUA3SMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:12:01 -0500
Date: Fri, 30 Jan 2004 19:11:59 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Timothy Miller <miller@techsource.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, John Bradford <john@grabjohn.com>,
       chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
In-Reply-To: <401A9716.3040607@techsource.com>
Message-ID: <Pine.LNX.4.55.0401301858070.10311@jurand.ds.pg.gda.pl>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no>
 <401A8E0E.6090004@techsource.com> <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
 <401A9716.3040607@techsource.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Timothy Miller wrote:

> You're not entirely correct here.  I attempted to write a VGA BIOS for a 
> card which did not have hardware support for 80x25 text.
> 
> I first tried intercepting int 0x10.  I quickly discovered that most DOS 
> programs bypass int 0x10 and write directly to the display memory.  As a 
> result, very little of what should have displayed actually did.

 Of course, but DOS is not BIOS and the assumption is we want to use the
adapter as a boot console and with Linux.  The former is handled with
appropriate firmware and the latter with a driver.

 Actually I had an opportunity to use a few PC/AT headless systems (no
video adapter at all, although one could be placed in a PCI slot) with an
option called "serial console redirection" in the firmware.  Their BIOS
setup program proved to work just fine over a serial line (unfortunately a
VT100 terminal was assumed, so I had to type e.g. ^[OP to "press" <F1>,
but it worked) as well any console output, including LILO (which had to be
taught to use the regular console instead of accessing the serial port for
I/O directly).

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
