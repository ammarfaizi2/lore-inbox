Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129553AbRBFJix>; Tue, 6 Feb 2001 04:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129599AbRBFJin>; Tue, 6 Feb 2001 04:38:43 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:48000 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129553AbRBFJie>; Tue, 6 Feb 2001 04:38:34 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <14A23BF37616@vcnet.vc.cvut.cz> 
In-Reply-To: <14A23BF37616@vcnet.vc.cvut.cz> 
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org,
        wakko@animx.eu.org
Subject: Re: Matrox Marvell G400 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 06 Feb 2001 09:36:59 +0000
Message-ID: <21341.981452219@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


VANDROVE@vc.cvut.cz said:
>  And if you insist on X, you can run first head through mga with
> usefbdev /dev/fb0 with hwcursor off, and secondary head through fbdev /
> dev/fb1. But it is not supported by me (and neither by XFree guys
> AFAIK, not even talking about Matrox support guys) - I support only
> first head in X and secondary head used for 'fbtv -k'.

Unless your machine is x86, and you use the binary-only HALlib from Matrox,
that is. :(

However, since the second heads of both G400 and G450 cards are supported 
in matroxfb, there's no real reason why the support in the 'real' XFree86 
driver should be so far behind. The main barrier to dual-head support in 
XFree86, last time I knew, was the lack of a way to _configure_ it. That's 
now been fixed, obviously. The HALlib is used only for mode setup, AFAICT. 
All acceleration is still done by the real driver. 

Petr - how much of the matroxfb code is yours to give, and would you permit
chunks of it to be reused under the XFree86 licence? Clean-room
reverse-engineering is such a PITA :)

> I'm trying... more or less. Next G450 BIOSes will have fix for
> matroxfb deadlock on boot, so there is at least some move. Although
> now when workaround is implemented in matroxfb, it is a bit late...

I think that workaround wants to be put in place for G400 too; not just 
G450.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
