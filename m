Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSDXQXo>; Wed, 24 Apr 2002 12:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312386AbSDXQXn>; Wed, 24 Apr 2002 12:23:43 -0400
Received: from viruswall2.epcnet.de ([62.132.156.25]:6923 "HELO
	viruswall.epcnet.de") by vger.kernel.org with SMTP
	id <S312381AbSDXQXn>; Wed, 24 Apr 2002 12:23:43 -0400
Date: Wed, 24 Apr 2002 18:23:35 +0200
From: jd@epcnet.de
To: davem@redhat.com
Subject: AW: Re: VLAN and Network Drivers 2.4.x
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <527944032.avixxmail@nexxnet.epcnet.de>
In-Reply-To: <20020424.060441.26508799.davem@redhat.com>
X-Priority: 3
X-Mailer: avixxmail 1.2.2.7
X-MAIL-FROM: <jd@epcnet.de>
Content-Type: text/plain; charset="iso-8859-1";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Von: <davem@redhat.com>
> Gesendet: 24.04.2002 16:11
>
>    2.4.x-kernel, when it's useless without patching Network Drivers?    
> It is not useless for the drivers that have been fixed.

Ok, but i have a stock 2.4.18 kernel, i can enable the VLAN option, recompile the kernel, configure a VLAN without any error or hint.

BUT: If i try to do ftp or ping with a payload greater than 1468 my tulipbased ZNYX 346Q ethernetcards drop those packets. The driver or the card cannot handle those packets. They are to large. Maybe a driverpatch solve my problem - maybe not. The kernel itself doesn't care. vconfig doesn't barf. It silently fails.. not so good behaviour in my opinion. This is why there are always the same questions on the vlan mailinglist.

> Because the solutions are hardware specific to allow these extra
> 4 bytes to be received by the card.  Some cards, in fact, cannot
> support VLAN at all because they cannot be programmed at all to
> take those 4 extra bytes.

Ok. But why isn't there a "tag" (capabilities?) on the drivers which let vconfig barf with a message like "underlying network driver or hardware doesn't support VLAN"?
 
> No it isn't useless.  There are many network drivers for which VLAN
> works out of the box RIGHT NOW.

Ok. But i don't get a message about the drivers which don't work. Which driver work/which not? Isn't it easier to tag all drivers as not VLAN-ready till somebody make a patch or confirm that its working with VLAN?

On the other side, my ZNYX works "out of the box" too. It works till 1468 Bytes ;) - I tend to say that ALL nic-drivers/hardware work till 1468 Bytes. But its not the intention of VLAN to lower the MTU on each Client.

