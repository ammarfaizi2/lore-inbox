Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279836AbRJ3DPh>; Mon, 29 Oct 2001 22:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279834AbRJ3DPR>; Mon, 29 Oct 2001 22:15:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279833AbRJ3DPK>; Mon, 29 Oct 2001 22:15:10 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Ethernet NIC dual homing
Date: 29 Oct 2001 19:15:39 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9rl60r$g50$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0110291831160.9540-100000@anime.net> <p05100304b803c6908755@[10.128.7.49]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p05100304b803c6908755@[10.128.7.49]>
By author:    Jonathan Lundell <jlundell@pobox.com>
In newsgroup: linux.dev.kernel
> >
> >It doesn't work to detect link state through bridging device (say, bridged
> >ethernet over T3). The T3 might go down, but your MII link to the local
> >router will remain "up", so you will never know about the loss of link and
> >your packets will happily go into the void...
> 
> ARP isn't going to do much for you once the failure is beyond the 
> local segment, is it?
> 

ARP is broadcast to the layer 2 local segment; link detection refers
to the layer 1 local segment, which is not necessarily the same.

On the other hand, doing link detection is extremely useful for a
portable computer: when I plug in my Ethernet cable in a portable
system I want it to try to start doing DHCP detection and anything
else that is normally associated with the interface being "up" at that
time.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
