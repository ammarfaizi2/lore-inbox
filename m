Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136394AbRD2WPI>; Sun, 29 Apr 2001 18:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136391AbRD2WO6>; Sun, 29 Apr 2001 18:14:58 -0400
Received: from ns.snowman.net ([63.80.4.34]:27140 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S136392AbRD2WOq> convert rfc822-to-8bit;
	Sun, 29 Apr 2001 18:14:46 -0400
Date: Sun, 29 Apr 2001 18:14:00 -0400 (EDT)
From: <nick@snowman.net>
To: Steffen Persvold <sp@scali.no>
cc: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@club-internet.fr>,
        lkml <linux-kernel@vger.kernel.org>, davej@suse.de, troels@thule.no
Subject: Re: ServerWorks LE and MTRR
In-Reply-To: <3AEC8223.DD87ADFE@scali.no>
Message-ID: <Pine.LNX.4.21.0104291813490.32327-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure that is not due to board design differences?
	Nick

On Sun, 29 Apr 2001, Steffen Persvold wrote:

> Gérard Roudier wrote:
> > 
> > On Sun, 29 Apr 2001, Steffen Persvold wrote:
> > 
> > > Hi all,
> > >
> > > I just compiled 2.4.4 and are running it on a Serverworks LE motherboard.
> > > Whenever I try to add a write-combining region, it gets rejected. I took a peek
> > > in the arch/i386/kernel/mtrr.c and found that this is just as expected with
> > > v1.40 of the code. It is great that the mtrr code checks and prevents the user
> > > from doing something that could eventually lead to data corruption. Using
> > > write-combining on PCI acesses can lead to this on certain LE revisions but
> > > _not_ all (only rev < 5). Therefore please consider my small patch to allow the
> > > good ones to be able to use write-combining. I have several rev 06 and they are
> > > working fine with this patch.
> > 
> > You wrote that 'only rev < 5' can lead to data corruption, but your patch
> > seems to disallow use of write combining for rev 5 too.
> > 
> > Could you clarify?
> 
> Oops just a typo, it should be <= 5. The patch is correct.
> 
> > 
> >   Gérard.
> > 
> > PS:
> > >From what hat did you get this information ? as it seems that ServerWorks
> > require NDA for letting know technical information on their chipsets.
> > 
> 
> I've learned it the hard way, I have two types : Compaq DL360 (rev 5) and a
> Tyan S2510 (rev 6). On the compaq machine I constantly get data corruption on
> the last double word (4 bytes) in a 64 byte PCI burst when I use write
> combining on the CPU. On the Tyan however the transfer is always ok.
> 
> -- 
>  Steffen Persvold                        Systems Engineer
>  Email  : mailto:sp@scali.com            Scali AS (http://www.scali.com)
>  Norway : Tel  : (+47) 2262 8950         Olaf Helsets vei 6
>           Fax  : (+47) 2262 8951         N-0621 Oslo, Norway
> 
>  USA    : Tel  : (+1) 713 706 0544       10500 Richmond Avenue, Suite 190
>                                          Houston, Texas 77042, USA
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

