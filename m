Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUA3TJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUA3TJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:09:51 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:21705 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263107AbUA3TJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:09:49 -0500
Date: Fri, 30 Jan 2004 20:09:47 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Timothy Miller <miller@techsource.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, John Bradford <john@grabjohn.com>,
       chakkerz@optusnet.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
In-Reply-To: <401AA08F.6020507@techsource.com>
Message-ID: <Pine.LNX.4.55.0401301953270.10311@jurand.ds.pg.gda.pl>
References: <4017F2C0.4020001@techsource.com> <200401291211.05461.chakkerz@optusnet.com.au>
 <40193136.4070607@techsource.com> <200401291629.i0TGTN7S001406@81-2-122-30.bradfords.org.uk>
 <40193A67.7080308@techsource.com> <200401291718.i0THIgbb001691@81-2-122-30.bradfords.org.uk>
 <4019472D.70604@techsource.com> <200401291855.i0TItHoU001867@81-2-122-30.bradfords.org.uk>
 <40195AE0.2010006@techsource.com> <401A33CA.4050104@aitel.hist.no>
 <401A8E0E.6090004@techsource.com> <Pine.LNX.4.55.0401301812380.10311@jurand.ds.pg.gda.pl>
 <401A9716.3040607@techsource.com> <Pine.LNX.4.55.0401301858070.10311@jurand.ds.pg.gda.pl>
 <401AA08F.6020507@techsource.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, Timothy Miller wrote:

> >  Of course, but DOS is not BIOS and the assumption is we want to use the
> > adapter as a boot console and with Linux.  The former is handled with
> > appropriate firmware and the latter with a driver.
> 
> Perhaps someone can tell us what the Linux kernel does before the 
> console driver gets loaded.

 The kernel does lot of activities, but if you mean console output, then
it doesn't start before the console driver is initialized, unless a
so-called initial console with a suitable driver is present, which may be
firmware-driven (so the driver may be a trivial redirector to appropriate
firmware callbacks).

> If the console driver is a module, then all kernel init messages that 
> appear before the module is loaded have nowhere to go.

 If there's no better console available, e.g. because there's no suitable
hardware present in the system or no drivers have been loaded, then the
dummy console is used -> drivers/video/console/dummycon.c.

 And if you worry of the messages being lost, then you can always retrieve
them from the kernel log buffer -- use `dmesg' for example. ;-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
