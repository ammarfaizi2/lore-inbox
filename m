Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWE1SlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWE1SlG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 14:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWE1SlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 14:41:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20144 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750863AbWE1SlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 14:41:05 -0400
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: Nathan Laredo <laredo@gnu.org>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
In-Reply-To: <m3k686hvzi.fsf@zoo.weinigel.se>
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	 <1148825088.1170.45.camel@praia>
	 <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
	 <1148837483.1170.65.camel@praia>  <m3k686hvzi.fsf@zoo.weinigel.se>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 28 May 2006 15:40:54 -0300
Message-Id: <1148841654.1170.70.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1-2mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Dom, 2006-05-28 às 19:58 +0200, Christer Weinigel escreveu:
> Mauro Carvalho Chehab <mchehab@infradead.org> writes:

> dpc7146, hexium_orion and mxb don't match all PCI IDs, they only match
> boards with zero as a board ID.  So they won't conflict with
> non-broken boards that have valid subvendor IDs.  But they will
> conflict with each other.
Yes. it is this I was trying to say :)
> 
> How may of these boards are broken and have zeroes in the
> subvendor/subdevice fields?  Apparently some of the dpc7146f,
> hexium_orion, mxb, and stradis boards are broken.  How many of the
> boards supported by the generic saa7146 driver are broken the same
> way?
I don't have any saa7146 board, but, on bttv, most boards don't have its
own PCI ID.
> 
> Can't the stradis driver do the same thing as the other drivers and
> explicitly match the broken zero subvendor id and the non-broken
> subvendor IDs?
> 

> That would fix the problem for me and make it SEP. :-)

This seems to be an interesting idea: to make stradis just probe the
recognized IDs and the generic one. It won't solve, however, the probing
intersection for dpc7146f, hexium_orion, mxb, and stradis when no
subvendor ID is specified on the board.
> 
> Can somebody with a SDM2xx stradis board mail me the output from
> "lspci -vn" and I'll cobble together a patch that does this?
> 
> This still needs solving properly, but at least it makes it less of
> a problem for people with non-broken hardware.
> 
>   /Christer
> 
Cheers, 
Mauro.

