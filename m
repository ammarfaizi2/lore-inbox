Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSC2MaE>; Fri, 29 Mar 2002 07:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313207AbSC2M3y>; Fri, 29 Mar 2002 07:29:54 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:48657 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S313206AbSC2M3m>;
	Fri, 29 Mar 2002 07:29:42 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andre Pang <ozone@algorithm.com.au>
Date: Fri, 29 Mar 2002 13:26:55 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Screen corruption in 2.4.18
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <D76FDC2172@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Mar 02 at 13:05, Andre Pang wrote:
> On Fri, Mar 29, 2002 at 01:14:47AM +0100, Danijel Schiavuzzi wrote:
> 
> > > 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
> > > 81) 00:01.0 
> > 
> > It's interesting that everyone who is experiencing these problems has the 
> > *revision 81* of the VT8365 chipset! This should be the key...
> 
> You know, we might be barking down the wrong tree.  (Arf.)

>From my findings revision 81 is KL133/KL133A (and only KL133 is affected
by clearing bit 5 in 0x55, KL133A works fine in both configs). KM133/KM133A
have revision 84, and KM133 is affected (I have no idea about KM133A).

> So far, everybody who has reported video corruption seems to have
> a Savage or ProSavage video card.  Maybe it'd be a better idea to

Because of they are integrated with K[LM]133...

> look at the ProSavage data sheets and see if we should be
> tweaking something there?  That would be much safer than playing
> around with the northbridges.

As now we have also report (from G550 user) that PCI -> AGP transfers 
are broken when bit 5 is cleared, I think that playing dangerous games
with northbridge is only way to go.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
