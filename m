Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSFCSOB>; Mon, 3 Jun 2002 14:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317448AbSFCSOA>; Mon, 3 Jun 2002 14:14:00 -0400
Received: from pD952AF1C.dip.t-dialin.net ([217.82.175.28]:21124 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314485AbSFCSN7>; Mon, 3 Jun 2002 14:13:59 -0400
Date: Mon, 3 Jun 2002 12:13:29 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: jt@hpl.hp.com, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Dan Aloni <da-x@gmx.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Link order madness :-( 
In-Reply-To: <200206031729.g53HTwTo002828@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.44.0206031209541.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 3 Jun 2002, Horst von Brand wrote:
> There should be a way of saying "This must be initialized after this, and
> before that" (the "before that" might perhaps be taken care of by the
> "that" itself). Spiced with a few "barriers": "Networking inited", etc.

Suggestion #1: make up an inittask table (bad idea, huge table) that gets 
freed on end of init.

Suggestion #2: each big subsystem (net, scsi, pcmcia, etc.) gets a lock 
that is engaged when starting, and is checked by the subsystems. The 
subsystems' init won't take place unless the parent subsystem is up. At 
end of init, these locks get freed.

Suggestion #3 (possibly the worst ever): let the subsubsystems be init'ed 
by the subsystems, using #ifdef'd calls...

I must leave now, sorry.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

