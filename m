Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263076AbVCQOfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbVCQOfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVCQOfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:35:22 -0500
Received: from web25101.mail.ukl.yahoo.com ([217.12.10.49]:56691 "HELO
	web25101.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263076AbVCQOew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:34:52 -0500
Message-ID: <20050317143450.83739.qmail@web25101.mail.ukl.yahoo.com>
Date: Thu, 17 Mar 2005 15:34:49 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [UART] 8250:RTS/CTS flow control issue.
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>I, therefore, strongly suggest that you arrange to do
the same - iow,
>deassert RTS when your buffer is approaching approx.
2/3 full rather
>than absolutely full.

Well, I don't think this gonna work because my rx fifo
is only 8 bytes
length and 8250's one is 16 bytes length. This means
that if I
deassert RTS when my fifo is 5 bytes full, I can
potentially receive 8
bytes and thus get an overrun...

But why should I "degrade" my UART because some 8250
devices have
poor hardware implementation. Maybe we should limit
their tx fifo to
one byte when rts/cts flow control is enabled...

thanks

	Francis


	

	
		
Découvrez nos promotions exclusives "destination de la Tunisie, du Maroc, des Baléares et la Rép. Dominicaine sur Yahoo! Voyages :
http://fr.travel.yahoo.com/promotions/mar14.html
