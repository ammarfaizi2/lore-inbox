Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSHUJEA>; Wed, 21 Aug 2002 05:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSHUJEA>; Wed, 21 Aug 2002 05:04:00 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:21191 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S318085AbSHUJD7>; Wed, 21 Aug 2002 05:03:59 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: bttv-driver: help required with new card
Date: 21 Aug 2002 08:39:45 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrnam6keh.4m0.kraxel@bytesex.org>
References: <20020821075942.GF11372@finarfin.forwiss.uni-passau.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1029919185 4825 127.0.0.1 (21 Aug 2002 08:39:45 GMT)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  I have a framegrabber to work with linux (2.4.18). It's a BT878
>  device and I have a lot of questions :(
>  
>  a) It does not use the muxsel-bits in BT848_IFORM but some bits in
>     BT848_GPIO_DATA to select video-input---so seems to be a quite
>     unusual device.
>  
>     Should I make switch(btv->type) statments in bt848_muxsel?

No.  Pick the latest driver and use the muxsel_hook.

>  b) several registers have to be initialised to other values then
>     usual, to make the card work.
>  
>     At the moment I'm doing this in bt848_muxsel, but I would like to
>     move to a place where it is not executed every time I switch input
>     Is init_bt848 the right place?

No.  Have you noticed the bttv-cards.c file?  There is plenty of
card-specific initialization code.  bttv_init_card2() likely is the
proper place.

>  c) It does not identify with PCI_SUBSYSTEM_ID/PCI_SUBSYSTEM_VENDOR_ID
>     (gives 0xffff). Any other way to autodetect it?

Sorry, no.  Use the card=foo insmod option and flame the vendor of the
card.

>  d) Who is the bttv-maintainer?!

/me.

How about reading documentation?  Documentation/video4linux/bttv/ for
example?

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
