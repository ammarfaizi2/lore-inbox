Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSGIWpk>; Tue, 9 Jul 2002 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSGIWpj>; Tue, 9 Jul 2002 18:45:39 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24071 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317443AbSGIWpj>; Tue, 9 Jul 2002 18:45:39 -0400
Subject: Re: How many copies to get from NIC RX to user read()?
To: hurwitz@lanl.gov (Hurwitz Justin W.)
Date: Wed, 10 Jul 2002 00:11:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207091625460.2905-100000@alvie-mail.lanl.gov> from "Hurwitz Justin W." at Jul 09, 2002 04:29:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17S497-0005vY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How many times is data copied between the time that it is received at the
> NIC and when the user's call to read() returns the data?

Optimal case for TCP

NIC->buffer (DMA)
buffer->user (CPU)

IFF the TCP checksum can be done by the card

