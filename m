Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131537AbQKZOzk>; Sun, 26 Nov 2000 09:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131560AbQKZOza>; Sun, 26 Nov 2000 09:55:30 -0500
Received: from einhorn.colt.in-berlin.de ([213.61.118.8]:27918 "EHLO
        einhorn.in-berlin.de") by vger.kernel.org with ESMTP
        id <S131537AbQKZOzQ>; Sun, 26 Nov 2000 09:55:16 -0500
To: linux-kernel@vger.kernel.org
Path: kraxel
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: [patch] Re: bttv crashes kernel 2.4.0testX on a Vodoo3 2000
Date: 26 Nov 2000 13:50:18 GMT
Organization: Strusel 007
Message-ID: <slrn92258o.g5a.kraxel@bogomips.masq.in-berlin.de>
In-Reply-To: <20001124112338.A523@BOFH.president.eu.org> <3A1E3206.114A8A9@suntiger.ee.up.ac.za>
NNTP-Posting-Host: bogomips.masq.in-berlin.de
X-Trace: goldbach.masq.in-berlin.de 975246618 25397 192.168.69.77 (26 Nov 2000 13:50:18 GMT)
X-Complaints-To: news@goldbach.in-berlin.de
NNTP-Posting-Date: 26 Nov 2000 13:50:18 GMT
User-Agent: slrn/0.9.6.3 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Schoeman wrote:
> With the VIA chipset you should use the "triton1=1" module option.
> (Well, at least it worked for me!)
> 
> -justin
> 
> > [1.] One line summary of the problem:
> >         bttv crashes kernel 2.4.0testX on a Vodoo3 2000
[ ... ]
> > PCI devices found:
> >   Bus  0, device   0, function  0:
> >     Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).

http://www.strusel007.de/linux/bttv/bttv-0.7.49-2.4.0-test11.diff.gz

<changelog>

bttv-0.7.49
-----------

 * changed more structs to name-based initialization (from test11 patch)
 * Added kernel args for the most important bttv insmod options, based
   on Werner Almesberger's patch.
 * Added insmod option to set the tuner type to bttv (yes, that's a bit
   redundant with the tuner module's option, but this way it works with
   two cards having different tuners too).
 * more fixes for card descriptions.
 * updated the triton1 compatibility code:  moved into bttv-cards.c,
   created a new function for it, reworked and commented the code.
   Added a list for chipsets, seems the triton1 isn't the only chipset
   which needs this.  Added the via apollo to the list.

</changelog>

If someone else has a board which needs the triton1=1 insmod option to
work stable with bttv just drop me a note (don't forget to include the
PCI ID for the Host bridge), I'll add it to the new blacklist then.
 
  Gerd

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
