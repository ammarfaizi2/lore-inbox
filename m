Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284251AbRLLA1S>; Tue, 11 Dec 2001 19:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284253AbRLLA1J>; Tue, 11 Dec 2001 19:27:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31752 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284243AbRLLA0d>; Tue, 11 Dec 2001 19:26:33 -0500
Subject: Re: SV: Lockups with 2.4.14 and 2.4.16
To: johan@ekenberg.se (Johan Ekenberg)
Date: Wed, 12 Dec 2001 00:36:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <000a01c1829f$75daf7a0$050010ac@FUTURE> from "Johan Ekenberg" at Dec 12, 2001 12:56:33 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DxNT-0007XI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > /var/spool volume hung and the mylex stopped responding
> > on that channel.
> 
> / and /var/spool are on the same channel on the Mylex. If it's a question of
> an entire channel hung up, / must be blocked too. Please note, this happened
> on several machines so I guess it's not a hardware fault in the Mylex card.

I was using "channel" in a logical sense, not a physical one. I agree
its not likely to be hardware

> In the meantime, are there any patches I should apply or other things to
> try? I'd rather see there is no "next time"... Since we also upgraded to
> ReiserFS 3.6 it seems difficult/impossible to quickly revert to a
> 2.2-kernel.(?) These are production machines and people are getting upset
> about these lockups.

If anything unapplying patches might be the first move, to eliminate hangs
caused by - say races in the quota patches you applied. I don't know of any
but thats always got to be a question since I've not seen identical reports
before this one.

Alan
