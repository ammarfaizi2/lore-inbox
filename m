Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271320AbTGQBsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271322AbTGQBsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:48:37 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:13440 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S271320AbTGQBsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:48:36 -0400
Date: Thu, 17 Jul 2003 04:03:24 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vojtech@suse.cz, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: PS2 mouse going nuts during cdparanoia session.
Message-ID: <20030717020324.GA1685@finwe.eu.org>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	vojtech@suse.cz, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
	davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
References: <200307162343.h6GNh5iu016584@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307162343.h6GNh5iu016584@harpo.it.uu.se>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:

> >This is basically because the check for lost bytes wasn't present in
> >2.4. Now that it is there, it works well with real lost bytes, but will
> >fire also in case when the mouse interrupt was delayed for more than
> >half a second, or if indeed a mouse interrupt gets lost. The 2.5 kernel
> >by default programs the mouse to high speed reporting (up to 200 updates
> >per second). This may, possibly make the problem show up easier.
> This was interesting: 2.5 programs the mouse differently than 2.4.
> I've been having ps2 mouse problems with the 2.5 input layer,
> including having to move the mouse much further for a given
> cursor movement, and a general jerky/unstable feeling of the mouse.

Strange. Here I've got problems with my mouse being actually 'to fast'
(when working with X-Window; I had to slow it down about 2 times via
xset to be able to work 'normally'; Actually -since I could not find
any related bugreports or complains - I thought it was something with 
how my version of X works with new layer) 

> 2.4's pc_keyb.c has (disabled by default) init code which puts the
> mouse in 100 samples/s and 2:1 scaling, whereas 2.5 puts it into
> 200 samples/s and 1:1 scaling. So I hacked psmouse-base.c to mimic
> 2.4, and VOILA! now my mouse feels A LOT better.

And here it goes even faster than before. 
Live is indeed full of suprises :)

[cut]

jk

-- 
Jacek Kawa  
