Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267303AbTAGMEZ>; Tue, 7 Jan 2003 07:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267322AbTAGMEY>; Tue, 7 Jan 2003 07:04:24 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:1733 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S267303AbTAGMEW>; Tue, 7 Jan 2003 07:04:22 -0500
Date: Wed, 08 Jan 2003 01:12:12 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Werner Almesberger <wa@almesberger.net>, Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux iSCSI Initiator, OpenSource (fwd) (Re: Gauntlet Set NOW!)
Message-ID: <18030000.1041941532@localhost.localdomain>
In-Reply-To: <20030107040829.E1406@almesberger.net>
References: <Pine.LNX.4.10.10301051924140.421-100000@master.linux-ide.org>
 <3E19B401.7A9E47D5@linux-m68k.org>
 <17360000.1041899978@localhost.localdomain>
 <20030107042045.GA10045@waste.org>
 <200301070538.h075cICR004033@turing-police.cc.vt.edu>
 <20030107031638.D1406@almesberger.net>
 <200301070643.h076hWCR004411@turing-police.cc.vt.edu>
 <20030107040829.E1406@almesberger.net>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, he really meant without.  I don't know if Valdis saw the presentation 
that went with that draft, but I did (last IETF in Yokohama).  The example 
was a 10Gbps link with a 250ms RTT (plausibly, a trans-pacific cable 
lambda).  There are tens of thousands of 9k packets in the window (yep, 100 
*megabytes* in flight in the cable!), and it does take several hours with 
exactly zero drops to get the connection to fill the 10Gbps.  After one 
dropped packet, it can take an hour to get back to full utilisation.  The 
graphs are really startling to look at :-)

That quirk just meant the numbers were off by a few orders of magnitude.

If anyone wants to look at that further, I think there are URLs in the 
draft.  If not, I can dig them out of the proceedings.

Andrew

--On Tuesday, January 07, 2003 04:08:29 -0300 Werner Almesberger 
<wa@almesberger.net> wrote:

> Valdis.Kletnieks@vt.edu wrote:
>> That's not the problem. The problem is that TCP slow-start itself (and
>> some of the related congestion control stuff) has some issues scaling to
>> the very high end.
>
> I'm very well aware of that ;-) But what you wrote was:
>
>> it takes *hours* without a
>> packet drop to get the window open *all* the way
>
> Or did you mean "after" instead of "without" ? Or maybe "into
> equilibrium" instead of "the window open ..." ? (After all, the
> window isn't only open, but it's been blown off its hinges.)
>
> In any case, your statement accurately describes a somewhat
> surprising quirk in Linux TCP performance as of only a bit more
> than six years ago :)
>
> - Werner
>
> --
>
> _________________________________________________________________________
>  / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net
> /
> /_http://www.almesberger.net/____________________________________________/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>


