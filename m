Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313507AbSC3R01>; Sat, 30 Mar 2002 12:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313506AbSC3R0S>; Sat, 30 Mar 2002 12:26:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313505AbSC3R0E>; Sat, 30 Mar 2002 12:26:04 -0500
Subject: Re: PDC20269 error handling problem
To: manfred@colorfullife.com (Manfred Spraul)
Date: Sat, 30 Mar 2002 17:42:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <005401c1d7d7$20d53a30$010411ac@local> from "Manfred Spraul" at Mar 30, 2002 11:38:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16rMsL-0003OO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * the fallback causes a total system hang if the drive is connected to
> the promise controller.
> * it hangs on the "rep;insw;" instruction in ata_input_data(), called by
> try_to_flush_leftover_data().

That does sound like the drive didnt fall back properly - the rep insw would
then hang when the controller hangs the bus indefinitely waiting for a data
byte. Probably something got a little broken in the IDE updates

Alan
