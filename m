Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135595AbREEXtG>; Sat, 5 May 2001 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135596AbREEXs4>; Sat, 5 May 2001 19:48:56 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:2835 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S135595AbREEXsl>;
	Sat, 5 May 2001 19:48:41 -0400
Message-ID: <3AF49617.1B3C48AF@candelatech.com>
Date: Sat, 05 May 2001 17:08:55 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] arp_filter patch for 2.4.4 kernel.
In-Reply-To: <3AF4720F.35574FDD@candelatech.com> <15092.32371.139915.110859@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Ben Greear writes:
>  > This patch is ported from Andi Kleen's work for the 2.2.19 kernel (I think
>  > it was his, at least...)
>  >
>  > It adds the ability to run multiple interfaces on the same subnet,
>  > on the same machine, and have the ARPs for each interface be answered
>  > based on whether or not the kernel would route a packet from the ARP'd
>  > IP out that interface.  When used with source-based routing, this
>  > makes things work in an intuitive manner.
> 
> How difficult is it to compose netfilter rules that do this?

No idea, haven't tried to use netfilter.  With this patch, though,
it's as easy as:

echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter


I have a setup that should be able to test some netfilter rules
if have some you want me to try....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
