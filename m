Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311483AbSDXNOK>; Wed, 24 Apr 2002 09:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311917AbSDXNOJ>; Wed, 24 Apr 2002 09:14:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23426 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311483AbSDXNOI>;
	Wed, 24 Apr 2002 09:14:08 -0400
Date: Wed, 24 Apr 2002 06:04:41 -0700 (PDT)
Message-Id: <20020424.060441.26508799.davem@redhat.com>
To: jd@epcnet.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: VLAN and Network Drivers 2.4.x
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <718111768.avixxmail@nexxnet.epcnet.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jd@epcnet.de
   Date: Wed, 24 Apr 2002 15:09:09
   
   why is a there a experimental VLAN option in the stable
   2.4.x-kernel, when it's useless without patching Network Drivers?
   
It is not useless for the drivers that have been fixed.

   Why isn't there a solution for all network drivers to accept frames
   4 bytes longer on request of e.g. vconfig (like ifconfig setting
   promiscious mode on/off) ? Or to deny vconfig to add a vlan, if the
   network driver/hardware doesn't support this?
   
Because the solutions are hardware specific to allow these extra
4 bytes to be received by the card.  Some cards, in fact, cannot
support VLAN at all because they cannot be programmed at all to
take those 4 extra bytes.

   Today the situation is as follows: The experimental VLAN-option is
   useless, if i dont patch my network drivers, otherwise there is no
   working VLAN function.
   
No it isn't useless.  There are many network drivers for which VLAN
works out of the box RIGHT NOW.  In fact, many of which support full
hardware acceleration of VLAN tagging, for instance Tigon3 is one
such device.

