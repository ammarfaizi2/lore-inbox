Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273703AbRIQVje>; Mon, 17 Sep 2001 17:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273704AbRIQVjZ>; Mon, 17 Sep 2001 17:39:25 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:10112 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273703AbRIQVjS>;
	Mon, 17 Sep 2001 17:39:18 -0400
Message-ID: <3BA66D93.E79BE485@candelatech.com>
Date: Mon, 17 Sep 2001 14:39:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip  
 aliasbug 2.4.9 and 2.2.19]
In-Reply-To: <20010906212303.A23595@castle.nmd.msu.ru> <20010906173948.502BFBC06C@spike.porcupine.org> <9n8ev1$qba$1@cesium.transmeta.com> <3B985FC6.B41000A3@candelatech.com> <3B986042.9050405@zytor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Ben Greear wrote:
> >
> > That will always work, even when you have multiple ethernet
> > interfaces??
> >
> 
> It better.  Otherwise you'd have the machine sending packets out one
> interface and in the other, and the two networks might not even be
> connected...
> 
>         -hpa

This is actually quite easy to have happen unless you turn on
arp-filter.  Put both interfaces on the same network and funny
things happen (pkts go in one IF, and out the other...).  Now,
you could probably argue that for such advanced (or broken)
networks, the user has to just be more careful/specific.  I don't
know about the details for this specific issue, but so long as
the tool(s) allow (even if it's a PITA) one to force the
configuration to happen correctly, then it's no big deal...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
