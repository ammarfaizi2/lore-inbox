Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278313AbRKHUx4>; Thu, 8 Nov 2001 15:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278309AbRKHUxj>; Thu, 8 Nov 2001 15:53:39 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:56839 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S278313AbRKHUxZ>; Thu, 8 Nov 2001 15:53:25 -0500
Date: Thu, 8 Nov 2001 21:53:19 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>
Subject: Re: [PATCH] 802.1q-support for 3c59x.c
Message-ID: <20011108215319.G9684@devcon.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	VLAN Mailing List <vlan@Scry.WANfear.com>
In-Reply-To: <20011107165318.A15577@devcon.net> <3BE95B6E.E4EB1B86@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BE95B6E.E4EB1B86@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Nov 07, 2001 at 11:03:58AM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 11:03:58AM -0500, Jeff Garzik wrote:
> > 
> > +/* The Ethernet Type used for 802.1q tagged frames */
> > +#define VLAN_ETHER_TYPE 0x8100
> This needs to be ETH_P_8021Q from if_ether.h.

OK. An updated patch will follow in a few days, as Alan requested not
sending new patches for some days.

> Have you tested this?

Sure. I'm actually using it in production, and other people also
reported that it works well without any problems.

> I should think you would need a dev->change_mtu
> also.

No. The whole point of the patch is that you /don't/ have to change
the MTU on the physical interface for VLAN support.

Though with the registers I figured from the specs it will be only a
matter of a few lines to add a dev->change_mtu to the driver. I can
add it to the patch if someone wants it.

Another question, how do you feel about the #ifdefs in the patch? As
said before, always enabling will not pose any performance penalties
to those not using VLAN tagging, so I could equally well just remove
them if noone objects.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
