Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264469AbRFTB0E>; Tue, 19 Jun 2001 21:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264470AbRFTBZz>; Tue, 19 Jun 2001 21:25:55 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:56773 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264469AbRFTBZq>;
	Tue, 19 Jun 2001 21:25:46 -0400
Message-ID: <3B2FFB46.BBA2BA2C@candelatech.com>
Date: Tue, 19 Jun 2001 18:24:22 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vlan@Scry.WANfear.com
CC: "David S. Miller" <davem@redhat.com>, Dax Kelson <dkelson@gurulabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: [VLAN] Re: Should VLANs be devices or something else?
In-Reply-To: <3B2FCE0C.67715139@candelatech.com>
				<Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com> <15151.55017.371775.585016@pizda.ninka.net> <3B2FDD62.EFC6AEB1@candelatech.com> <3B2FEEE0.C57EC336@sch.bme.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcell Gal wrote:
> 

> I remember
> /proc/sys/net/ipv4/conf/
> was broken for about >300 devices. I do not know how's it today.

My VLAN code creates an entry for every vlan in /proc/net/vlan/
too, and it seems to quit creating entries after about 250 or so.
It's read-only info, so it doesn't seem to do too much harm.

I think there must be an 8-bit limit somewhere in the proc-fs.

> > Adding the hashed lookup for devices took the exponential curve out of
> > ip and ifconfig's performance, btw.
> 
> n^2 for creating n devices (in the unfortunate increasing or random
> order),
> (not 2^n), I guess.

It definately isn't fast, but then again, it is fast enough when you
only have 500 or so interfaces.  For the wierdos that want more, we
can just wait a little longer... :)

I'll offer the hashed-device-lookup
patch separately on my web site so it can be used if needed...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
