Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270231AbRHHAIi>; Tue, 7 Aug 2001 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270236AbRHHAI2>; Tue, 7 Aug 2001 20:08:28 -0400
Received: from ip240.cvd2.rb1.bel.nwlink.com ([207.202.151.240]:2060 "EHLO
	zot.localdomain") by vger.kernel.org with ESMTP id <S270231AbRHHAIX>;
	Tue, 7 Aug 2001 20:08:23 -0400
To: Riley Williams <rhw@MemAlpha.CX>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org>
From: Mark Atwood <mra@pobox.com>
Date: 07 Aug 2001 17:08:21 -0700
In-Reply-To: Riley Williams's message of "Wed, 8 Aug 2001 00:35:54 +0100 (BST)"
Message-ID: <m3k80fv2fe.fsf@flash.localdomain>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams <rhw@MemAlpha.CX> writes:
> 
> I've certainly never stood in the position you call "Kernel" in that
> description. Here's the situation as I see it, put in those sort of
> terms, characters being InitScripts and Kernel respectively:
> 
>  1. InitScripts points at Kernel saying "there is no good and no
>     well documented mapping method".
> 
>  2. Kernel replies "There is a good mapping method, which is to
>     always map the ports starting with the lowest numbered one."

Well, there is that present mapping method, but I hesitate to call it
"good".


Plus, we are unable to satisfactorily define "lowest numbered one".


If I build a system with several identical (other than MAC) FooCorp
PCI ethernics, they will number up in order of ascending MAC address.

I take the same system, replace the FooCorp cards with BarInc NICs, they
will number up in reverse MAC address.

Replace them instead with Baz Systems NICs, and I get them in bus scan
order (at which point I'm dependent on the firmware version of my PCI
bridge too!).

And if I elect to use Frob Networking NICs, I instead get them in the
*random* order that their oncard processors won the race to power up.


Gods and demons help me if I try putting several of all four brands in
one box, or the firmware on my NICs or in my PCI bridges changes!

> 
>  3. InitScripts then tells Kernel "But I don't want to map the ports
>     in ascending numerical order!"

The phrase "ascending numerical order" becomes, depending on if you
have a complex (lots of different kinds of interfaces) or dynamic
(ferex, with PCMCIA, CompactPCI, USB, and Firewire ethernet
interfaces), either useless or undefined.


-- 
Mark Atwood   | I'm wearing black only until I find something darker.
mra@pobox.com | http://www.pobox.com/~mra
