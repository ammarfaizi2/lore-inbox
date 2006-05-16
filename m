Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWEPMaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWEPMaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWEPMay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:30:54 -0400
Received: from usmimesweeper.bluearc.com ([63.203.197.133]:53509 "EHLO
	us-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1751805AbWEPMay convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:30:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":": i82875p UE
Date: Tue, 16 May 2006 13:30:08 +0100
Message-ID: <89E85E0168AD994693B574C80EDB9C2703F774F6@uk-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, labels ":": i82875p UE
Thread-Index: AcZ4xoY7aoOih3OoQumlqSQQrI70GwAHPBLA
From: "Andy Chittenden" <AChittenden@bluearc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Every one of our ASUS P4C800-E and ASUS P4C800 based machines 
> that I've installed a 2.6.16 smp based kernel on is logging 
> messages of the form:
> 
> EDAC MC0: UE page 0x1fffa, offset 0x0, grain 4096, row 0, 
> labels ":": i82875p UE
> 
> every second or so. So I've downgraded them back to 2.6.15. I 
> believe the message is moaning that the ECC memory has 
> unrecoverable errors. However, the memory in the machines 
> I've tried passes memtest. And I'd've expected system hangs 
> which we don't get.

Well, memtest passes if I don't enable ECC in memtest. However, if I do,
it fails. So it looks like we've got a memory/memory controller issue
(the fact that it's happening on all machines with these motherboards
implies to me that's a controller/bios issue rather than a memory
issue). If I update the AGP aperture in the BIOS to 256Mb (from 64Mb),
memtest with ECC enabled passes but linux then boots up extremely
slowly. So is this also going to be motherboard/bios issue?

-- 
Andy, BlueArc Engineering
