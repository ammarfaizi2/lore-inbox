Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276095AbRJBSTu>; Tue, 2 Oct 2001 14:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276109AbRJBSTk>; Tue, 2 Oct 2001 14:19:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37129 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276103AbRJBSTY>; Tue, 2 Oct 2001 14:19:24 -0400
Subject: Re: Huge console switching lags
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Tue, 2 Oct 2001 19:24:07 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton),
        lenstra@tiscalinet.it (Lorenzo Allegrucci),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0110021408310.22872-100000@sweetums.bluetronic.net> from "Ricky Beam" at Oct 02, 2001 02:10:41 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oUD9-0005Ua-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And what's the brilliant reason for this?  And don't give any BS about it
> taking too long inside an interrupt context -- we're switching consoles not
> start netscrape.

A console switch has to wait until queued I/O to that console is complete,
which in turn could take a measurable amount of time - so it has to block.
Also a console switch on a frame buffer with no hardware banking can take
a lot of time.


Alan
