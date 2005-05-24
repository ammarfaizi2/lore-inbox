Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVEXE0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVEXE0O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 00:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXE0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 00:26:13 -0400
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:22580 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S261178AbVEXE0K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 00:26:10 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: ide-cd vs. DMA
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Date: Mon, 23 May 2005 23:26:08 -0500
Message-ID: <18DFD6B776308241A200853F3F83D50702128D31@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ide-cd vs. DMA
Thread-Index: AcVgELP/4Gsbm9IbR4CTfQftOKxvWQAB2BPg
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>, <karim@opersys.com>
Cc: "Jens Axboe" <axboe@suse.de>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you using hdparm -k1 to keep your settings over a reset?  If you're 
not, then this behaviour is really by-design.

-----Original Message-----
From: Benjamin Herrenschmidt
Sent: May 23, 2005 10:25 PM
Subject: Re: ide-cd vs. DMA

Well, not sure what's wrong here, but ATAPI errors shouldn't normally
result in stopping DMA. We may want to just blacklist your drive rather
than having this stupid fallback. In this case, I suspect it's
CSS/region issue with a DVD.

Ben.
