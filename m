Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQKNT4D>; Tue, 14 Nov 2000 14:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQKNTzx>; Tue, 14 Nov 2000 14:55:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:60943 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129415AbQKNTzg>;
	Tue, 14 Nov 2000 14:55:36 -0500
Date: Tue, 14 Nov 2000 19:42:24 +0100
Message-Id: <200011141842.TAA03384@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: tmolina@home.com (Thomas Molina)
Cc: linux-kernel@vger.kernel.org
Subject: Re: opl3.o initialization problems in 2.4
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.21.0011140825020.1788-100000@wr5z.localdomain>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0011140825020.1788-100000@wr5z.localdomain> you wrote:
> I continue to see apparent interaction problems between sb.o and opl3.o
> during system initialization.  Several people have reported problems
> with the opl3.o module not loading or not working properly.  A
> workaround was developed which results in a functional system; if sb.o
> is compiled as built-in and opl3.o is compiled modular things work.  

> My working theory is that the soundcard must be initialized and the
> driver functioning before the opl3 module can initialize its function on
> the card.  Currently, the opl3 code is executed before the soundcard
> code and is unable to initialize the fm synthesizer.  

> I hate to reignite the link order war, but I would appreciate a
> clarification of the situation.

This is strange. CONFIG_SOUND_YM3812 (the opl3 config options)
is actually _after_ CONFIG_SB in the Makefile.

Does it work if both drivers are modular?


	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
