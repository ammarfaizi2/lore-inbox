Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130449AbQLIN1w>; Sat, 9 Dec 2000 08:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130540AbQLIN1m>; Sat, 9 Dec 2000 08:27:42 -0500
Received: from hera.cwi.nl ([192.16.191.1]:49917 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130449AbQLIN10>;
	Sat, 9 Dec 2000 08:27:26 -0500
Date: Sat, 9 Dec 2000 13:56:59 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@chiara.elte.hu>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
Message-ID: <20001209135659.B839@veritas.com>
In-Reply-To: <Pine.LNX.4.10.10012082356020.2121-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012090415330.29053-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0012090415330.29053-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 09, 2000 at 05:40:47AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 05:40:47AM -0500, Alexander Viro wrote:

> > @@ -1210,7 +1204,6 @@
> [breada()]
> 	Umm... why do we keep it, in the first place? AFAICS the only
> in-tree user is hpfs_map_sector() and it doesn't look like we really
> need it there. OTOH, trimming the buffer.c down is definitely nice.
> Mikulas?

Throw it out. The number of users has diminished over time.
Recently isofs stopped using breada.
The hpfs use was broken, I fixed it a bit some time ago, but
there is nothing against throwing it out altogether, I think.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
