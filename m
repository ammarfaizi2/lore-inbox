Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273354AbRINJcl>; Fri, 14 Sep 2001 05:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273350AbRINJcb>; Fri, 14 Sep 2001 05:32:31 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:20088 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S273351AbRINJcS>; Fri, 14 Sep 2001 05:32:18 -0400
Date: Fri, 14 Sep 2001 11:34:52 -0400 (EDT)
From: Francis Galiegue <fg@mandrakesoft.com>
To: Erich Schubert <erich.schubert@mucl.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compaq Presario Notebook Keyboard "Extensions"
In-Reply-To: <20010913124623.A22927@erich.xmldesign.de>
Message-ID: <Pine.LNX.4.30.0109141126560.1617-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2001, Erich Schubert wrote:

>
> Compaq Presario Notebooks (i don't know which ones, at least my Presario
> 1400 and a friend's Presario 1200) have some additional Keys on the keyboard
>
> These keys apparently do not generate scancodes, i also noticed no
> interrupts being generated.
> I also tried using "kbd-init", but it didn't help either.
>

Exactly the same here. I've been playing some time with extra keys,
either on PC keyboards and notebooks. My Compaq Presario 1926 just acts
like yours when I hit these extra keys: nothing to be seen. Maybe a
dedicated I/O port? Haven't tried yet.

I've also seen two other cases: keys generating NMIs (yes!) and keys
directly "attacking" hardware. In either case, showkey -s doesn't show
anything. On all desktop PC keyboards that I could lay my hands on
otherwise, it generates e0 xx scancodes on press and e0 (xx | 0x80) on
release. Some of these scancodes even seem to be standard (volume up and
down, play and pause key...). I made a dedicated driver to handle these
keys for 2.2 already. Not yet ported to 2.4.

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

