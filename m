Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268018AbTAKUPK>; Sat, 11 Jan 2003 15:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268102AbTAKUPK>; Sat, 11 Jan 2003 15:15:10 -0500
Received: from dialin-145-254-062-029.arcor-ip.net ([145.254.62.29]:31360 "EHLO
	portable.localnet") by vger.kernel.org with ESMTP
	id <S268018AbTAKUPJ> convert rfc822-to-8bit; Sat, 11 Jan 2003 15:15:09 -0500
Date: Sat, 11 Jan 2003 21:20:56 +0100 (CET)
Message-Id: <20030111.212056.607951684.rene.rebe@gmx.net>
To: kernel@nn7.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: choice of raid5 checksumming algorithm wrong ?
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <1042314720.1225.4.camel@sun>
References: <3E203C00.5060403@inet6.fr>
	<20030111.203913.846936097.rene.rebe@gmx.net>
	<1042314720.1225.4.camel@sun>
X-Mailer: Mew version 2.2 on XEmacs 21.4.10 (Military Intelligence)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

In the case s.o. wants to pull the patch:

http://www.rocklinux.org/sources/package/base/linux24/82-raid5-niceer-output.patch

It is only a one-liner. It is not really nice since I print the
"writing arround L2 cache" text when XOR_SELECT_TEMPLATE is defined -
this might also be the case for an later AlitVec version for PowerPC
or so. So we might want a more generic text - or a text in the
appropriated .h file whetre XOR_SELECT_TEMPLATE is defined ...

On: 11 Jan 2003 20:52:00 +0100,
    Soeren Sonnenburg <kernel@nn7.de> wrote:
> On Sat, 2003-01-11 at 20:39, Rene Rebe wrote:
> > Hi.
> > 
> > I also consider the kprint message a useability bug - and this is why
> > I posted a patch that prints out that the algorithm is choosen to
> > write "arround" the L2 cache ... - We patch this in our ROCK Linux
> > standard patches ...
> 
> I would vote for such a cosmetic patch to be included...
> 
> Soeren.
> 
> > On: Sat, 11 Jan 2003 16:45:04 +0100,
> >     Lionel Bouton <Lionel.Bouton@inet6.fr> wrote:
> > > Soeren Sonnenburg wrote:
> > > 
> > > >Hi!
> > > >
> > > >I really do wonder whether the displayed message is wrong or why it
> > > >always chooses the slowest checksumming function (happens with 2.4.19 -
> > > >21pre3)
> > > >  
> > > >
> > > SSE is always preferred because unlike other checksumming code it 
> > > doesn't use the processor caches when reading/writing data/checksum.
> > > This is slower (if several GB/s can be considered slow) for the 
> > > checksumming but far better for the overall system performance.
> > > 
> > > LB.
> > 
> > - René
> > 
> > --  
> > René Rebe - Europe/Germany/Berlin
> > e-mail:   rene.rebe@gmx.net, rene@rocklinux.org
> > web:      www.rocklinux.org, drocklinux.dyndns.org/rene/
> > 
> > Anyone sending unwanted advertising e-mail to this address will be
> > charged $25 for network traffic and computing time. By extracting my
> > address from this message or its header, you agree to these terms.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
