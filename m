Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277324AbRJLKV0>; Fri, 12 Oct 2001 06:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277326AbRJLKVR>; Fri, 12 Oct 2001 06:21:17 -0400
Received: from mail1.dexterus.com ([212.95.255.99]:30480 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S277324AbRJLKVG>; Fri, 12 Oct 2001 06:21:06 -0400
Message-ID: <3BC6C3AE.EE439E6C@dexterus.com>
Date: Fri, 12 Oct 2001 11:19:26 +0100
From: Vincent Sweeney <v.sweeney@dexterus.com>
Organization: Dexterus
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ullrich <chris@chrullrich.de>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <Pine.GSO.4.21.0110111538200.24742-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0110111835360.24742-100000@weyl.math.psu.edu> <20011012010846.A982@christian.chrullrich.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this patch also fixed my missing IDE partition problem.

Christian Ullrich wrote:
> 
> * Alexander Viro wrote on Thursday, 2001-10-11:
> 
> >       *Damn*.  grok_partitions() doesn't set the size of entire device
> > until it's done with check_partition().  Which means max_blocks() behaving
> > in all sorts of interesting ways, depending on phase of moon, etc.
> >
> >       Could you check if the following helps?
> 
> Yeah, that one did it.
> 
> dmesg (only the interesting parts):
> 
>  hdb:[63 10000305]
>  hdb1[10000368 68063184]
>  hdb2 <[10000431 20972889]
>  hdb5[48063519 30000033]
>  hdb6 >[78063552 1999872]
>  hdb3
> 
> reiserfs: checking transaction log (device 03:46) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> (this time, no errors to follow)
> 
> --
> Christian Ullrich                    Registrierter Linux-User #125183
> 
> "Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
