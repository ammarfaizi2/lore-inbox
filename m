Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbSAGRU1>; Mon, 7 Jan 2002 12:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281916AbSAGRUS>; Mon, 7 Jan 2002 12:20:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:22792 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281809AbSAGRUE>; Mon, 7 Jan 2002 12:20:04 -0500
Subject: Re: ALSA patch for 2.5.2pre9 kernel
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 7 Jan 2002 17:31:08 +0000 (GMT)
Cc: hch@ns.caldera.de (Christoph Hellwig), perex@suse.cz (Jaroslav Kysela),
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201070858150.6450-100000@penguin.transmeta.com> from "Linus Torvalds" at Jan 07, 2002 09:02:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ndc4-0001sW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or we could just have a really _deep_ hierarchy, and put everything under
> "linux/drivers/sound/..", but I'd rather break cleanly with the old.

Christoph has an interesting point. Networking is

	net/[protocol]/
	drivers/net/[driver]

so by that logic we'd have

	sound/soundcore.c
	sound/alsa/alsalibcode
	sound/oss/osscore

	sound/drivers/cardfoo.c

which would also be much cleaner since the supporting crap would be seperate
from the card drivers
