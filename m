Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272730AbRIGPpL>; Fri, 7 Sep 2001 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272732AbRIGPpC>; Fri, 7 Sep 2001 11:45:02 -0400
Received: from t2.redhat.com ([199.183.24.243]:19965 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272730AbRIGPow>; Fri, 7 Sep 2001 11:44:52 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.GSO.4.33.0109071132370.1190-100000@sweetums.bluetronic.net> 
In-Reply-To: <Pine.GSO.4.33.0109071132370.1190-100000@sweetums.bluetronic.net> 
To: Ricky Beam <jfbeam@bluetopia.net>
Cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: MTD and Adapter ROMs 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 07 Sep 2001 16:43:36 +0100
Message-ID: <4569.999877416@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jfbeam@bluetopia.net said:
>  Well, you explain where the f*** module "cfi" is located.  It took me
> a few hours to figure out what module is, in fact, "cfi". 

Heh, sorry about that. It's been fixed in my tree for a while - I should 
send Linus an update.

>  The question becomes, what section of the rom should not be erased?
> If I erase the entire 128k and then reset the system before getting a
> good image back in there, I'm betting it'll disappear from the bus.
> It's already screwed up to the point it no longer shows up in PCI
> space as itself -- which was entertaining to see the bad BIOS post and
> then not find itself :-)

Can't answer that. Try applying BIOS upgrades and downgrades, and seeing 
which ranges of the chip actually change?

> 00:03.0 Class ff80: 11ff:00ff (rev 03)
>  (that's supposed to be 1103:0004)

Looks like it's a pair of 8-bit flash devices side-by-side on a 16-bit bus, 
and you've managed to erase just one of them.


--
dwmw2


