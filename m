Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVECS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVECS3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVECS3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:29:39 -0400
Received: from firewall.miltope.com ([208.12.184.221]:36372 "EHLO
	smtp.miltope.com") by vger.kernel.org with ESMTP id S261536AbVECS3P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:29:15 -0400
Content-class: urn:content-classes:message
Subject: RE: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Tue, 3 May 2005 13:29:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <66F9227F7417874C8DB3CEB057727417045155@MILEX0.Miltope.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Thread-Index: AcVQBaT44uWrHA0NSgOcfJWhPhaiJwABVgqA
From: "Drew Winstel" <DWinstel@Miltope.com>
To: "Oskar Liljeblad" <oskar@osk.mine.nu>
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, now it loads correctly. Unfortunately the clock drift still occurs
> with pata_pdc2027x. I'm guessing here, but can clock drift have anything
> to do with IRQs? Also, is it normal to see errors in /proc/interrupt?

I've never noticed any errors before, but that could just be a result of me 
never actually bothering to look.

> # cat /proc/interrupts 

<snip>
> ERR:      23672

Hmmm....

I'm grasping at straws here.

Let's do some poking into your kernel config.  What do you have set under 
"Processor type and features"?  

I experienced a similar situation once in the past, but that was a result of 
drives losing DMA and doing simultaneous activity on eight drives and four 
controllers.  Moving to the pata_pdc2027x driver seems to have cleared it 
right up.

Sorry I can't provide a quick cure-all!

Drew
