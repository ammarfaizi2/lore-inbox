Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129130AbQKPDCW>; Wed, 15 Nov 2000 22:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129132AbQKPDCM>; Wed, 15 Nov 2000 22:02:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13066 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129130AbQKPDB4>; Wed, 15 Nov 2000 22:01:56 -0500
Date: Wed, 15 Nov 2000 18:31:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: aeb@veritas.com, emoenke@gwdg.de, eric@andante.org,
        koenig@tat.physik.uni-tuebingen.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: isofs broken (2.2 and 2.4)
In-Reply-To: <UTC200011160153.CAA107740.aeb@aak.cwi.nl>
Message-ID: <Pine.LNX.4.10.10011151829000.983-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000 Andries.Brouwer@cwi.nl wrote:
> 
> If noone else does, I suppose I can.

Thanks.

> 
> (> .. gets ENOENT ..
> and that is not because it only is a partial image?)

I don't think so, but I obviously have no way of actually confirming my
suspicion.

If the stat information was wrong due to the partial image, the lookup
should still have succeeded (the directory entries certainly were there -
otherwise they'd not have shown up in readdir), and we would just have
gotten garbage inode information etc. I think.

			Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
