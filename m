Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVCOQGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVCOQGC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:06:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVCOQGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:06:01 -0500
Received: from web25104.mail.ukl.yahoo.com ([217.12.10.52]:23705 "HELO
	web25104.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261355AbVCOQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:05:55 -0500
Message-ID: <20050315160554.2871.qmail@web25104.mail.ukl.yahoo.com>
Date: Tue, 15 Mar 2005 17:05:54 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: [UART] 8250:RTS/CTS flow control issue.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to use my serial port with rts/cts flow 
control enabled in order to transfer a data file
between 2 DTE. The first one is a PC running Linux
with a 8250 UART and the second one is a developement 
board running Linux with a particular UART (I wrote
its driver based on 8250's one).

Actually 8250 UARTs have rts/cts line but they're
managed by software (and then called hw flow control
!!!). Hence when my board's UART (which have a "true"
hw flow control) asserts its RTS line, 8250's UART
sends 8 bytes before stopping TX...
Therefore board's UART fifo have been overrun because
it has only 8 bytes for its fifo.

Does it mean that we can't do any reliable flow
controls with 8250 UART ? In that case a simple
workaround would be to limit tx fifo to 1 byte...

Thanks

     Francis



	

	
		
Découvrez nos promotions exclusives "destination de la Tunisie, du Maroc, des Baléares et la Rép. Dominicaine sur Yahoo! Voyages :
http://fr.travel.yahoo.com/promotions/mar14.html
