Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424734AbWKPWBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424734AbWKPWBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424735AbWKPWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 17:01:44 -0500
Received: from usea-naimss2.unisys.com ([192.61.61.104]:15374 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S1424734AbWKPWBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 17:01:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: How to go about debuging a system lockup?
Date: Thu, 16 Nov 2006 16:01:03 -0600
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D87@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to go about debuging a system lockup?
Thread-Index: AccJyrVgcshUufYbSgSl4HvsedN+pQ==
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>,
       "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Nov 2006 22:01:03.0532 (UTC) FILETIME=[B56EA6C0:01C709CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know of a good version yet.  I so far don't know if there ever
> was one.  This could even be a bug in the PCI hardware, or the way the
> BIOS on this system on a board configured the PCI controller.  Maybe I
> should go back and try a 2.4 kernel.
> 
> > Hope some of that helps :)
> 
> Well hopefully.
> 

If you can't drop in kdb, or no sysreq, then your interrupts are
disabled. I used to be (with older systems anyway) that NMI button was
on the system, so one could send an NMI and make the handler to print a
trace. Newer systems might not have that, so you can built your own PCI
card to send an NMI :)
Another possibility is to use port 80 and make suspicious code print
something to it. Once we used a small self-built thing with LEDs to
catch the output to the parallel port while debugging silent boot
failure. There are some port 80 cards that you can buy:
http://auctions.yahoo.com/i:Port%2080%20Card%20and%20power%20supply%20te
ster:102201489
http://www.amazon.com/gp/product/B000234U3I/ref=pd_cp_e_title/103-887558
8-5330221

If your system has a jtag then in target probe would be useful if you
have one (or can borrow one, those are expensive).

--Natalie

