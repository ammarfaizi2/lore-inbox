Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287386AbSAGXkh>; Mon, 7 Jan 2002 18:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287388AbSAGXk2>; Mon, 7 Jan 2002 18:40:28 -0500
Received: from jalon.able.es ([212.97.163.2]:5558 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S287386AbSAGXkQ>;
	Mon, 7 Jan 2002 18:40:16 -0500
Date: Tue, 8 Jan 2002 00:44:16 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Christoph Hellwig <hch@ns.caldera.de>, Jaroslav Kysela <perex@suse.cz>,
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA patch for 2.5.2pre9 kernel
Message-ID: <20020108004416.A23665@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.33.0201070858150.6450-100000@penguin.transmeta.com> <E16Ndc4-0001sW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E16Ndc4-0001sW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 07, 2002 at 18:31:08 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020107 Alan Cox wrote:
>
>so by that logic we'd have
>
>	sound/soundcore.c
>	sound/alsa/alsalibcode
>	sound/oss/osscore
>
>	sound/drivers/cardfoo.c
>

Would't it be better to split drivers:

sound/core.c
sound/alsa/alsa-core.c
sound/alsa/drivers/alsa-emu10k.c
sound/oss/oss-core.c
sound/oss/drivers/oss-emu10k.c

low level card drivers are different, and this way oss and alsa are
independent subtrees.

BTW, 2.5.x was born to be broken, so this is the moment to reorganize
the beast (better before than after kbuild 2.5 ?)

By

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre1-beo #1 SMP Fri Jan 4 02:25:59 CET 2002 i686
