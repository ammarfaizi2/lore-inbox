Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLHSNU>; Fri, 8 Dec 2000 13:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbQLHSNK>; Fri, 8 Dec 2000 13:13:10 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:40460 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129773AbQLHSNE>; Fri, 8 Dec 2000 13:13:04 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14897.7451.710204.633241@wire.cadcamlab.org>
Date: Fri, 8 Dec 2000 11:40:43 -0600 (CST)
To: root@chaos.analogic.com
Cc: Matthew Vanecek <linux4us@home.com>, Rainer Mager <rmager@vgkk.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Signal 11
In-Reply-To: <3A310E18.DD23D416@home.com>
	<Pine.LNX.3.95.1001208113945.1500A-100000@chaos.analogic.com>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Dick Johnson]
> > >   char main[]={0xf0,0x0f,0xc0,0xc8};    /* try also on NT (: */
> > me2v@reliant DRFDecoder $ ./op
> > Illegal instruction (core dumped)
> 
> Yep. And on early Pentinums, the ones with the "f00f" bug, it would
> lock the machine tighter than a witches crotch. Ooops, not
> politically correct.... It would allow user-mode code to halt the
> machine.

...Until Linux 2.0.34 or so (can't remember the exact version number)
which had the workaround for this bug, about a week after the bug was
discovered.

And I was reminded in private mail that the correct lockup sequence is
actually

  char main[]={0xf0,0x0f,0xc7,0xc8};

where the 0xc8 can be anything from 0xc8 to 0xcf.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
