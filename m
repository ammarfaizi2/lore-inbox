Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277804AbRJWPof>; Tue, 23 Oct 2001 11:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277802AbRJWPoP>; Tue, 23 Oct 2001 11:44:15 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277792AbRJWPoI>; Tue, 23 Oct 2001 11:44:08 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: jlundell@pobox.com (Jonathan Lundell)
Date: Tue, 23 Oct 2001 16:49:57 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mochel@osdl.org (Patrick Mochel),
        pavel@Elf.ucw.cz (Pavel Machek),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
In-Reply-To: <p05100303b7fb36bf20f5@[207.213.214.37]> from "Jonathan Lundell" at Oct 23, 2001 08:10:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w3oT-0006B6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is this a realistic example? That is, is a kernel-side driver likely 
> to be able to meaningfully extract state information from a scanner? 
> And is it necessary?

It may be a bad example - but think about things like page settings. Do you
want a resume to scan in colour when you set black and white just before
suspend ?


> And for a scanner, if the current operation is a scan generating a GB 
> of data, what happens if the disk subsystem is no longer accepting 
> requests?

It should have refused to suspend because it was active

> In that case, SUSPEND_SAVE_STATE becomes more like SUSPEND_QUIESCE: 
> stop accepting new requests, and complete current requests.

Maybe. That sounds like nice design and horrible implementation
