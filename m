Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264448AbRFTAaS>; Tue, 19 Jun 2001 20:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264450AbRFTAaJ>; Tue, 19 Jun 2001 20:30:09 -0400
Received: from linux.vmri.hu ([193.225.208.140]:34820 "EHLO linux.vmri.hu")
	by vger.kernel.org with ESMTP id <S264448AbRFTAaE>;
	Tue, 19 Jun 2001 20:30:04 -0400
Message-ID: <3B2FEEE0.C57EC336@sch.bme.hu>
Date: Wed, 20 Jun 2001 02:31:28 +0200
From: Marcell Gal <cell@sch.bme.hu>
Reply-To: cell@sch.bme.hu
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: "David S. Miller" <davem@redhat.com>, Dax Kelson <dkelson@gurulabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: Should VLANs be devices or something else?
In-Reply-To: <3B2FCE0C.67715139@candelatech.com>
			<Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com> <15151.55017.371775.585016@pizda.ninka.net> <3B2FDD62.EFC6AEB1@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Ben Greear wrote:

> >  > > Should VLANs be devices or some other thing?
> I found it to be the easiest way to implement things.  It allowed
> me to not have to touch any of layer 3, and I did not have to patch
> any user-space program like ip or ifconfig.

I faced the same issue when implementing RFC2684 (formerly 1483)
Ethernet over ATM-AAL5. Since users want to do the same thing
(ifconfig, tcpdump, rfc 2514 pppoe, dhcp, ipx) as with traditional eth0
using register_netdev was 'the right thing'.
However having the possibility of many devices annoyed
some people. (upto appr. 4095/ATM-VC in case of vlan over rfc2684 over
atm ;-)

My answer to the (old) 'long ifconfig listing' argument:
Users do not have more interfaces in the ifconfig listing than those they
create for themselves.
That's ok, exactly what they want. Those who do not like many interfaces
do not
create many.
The real thrill would be maintaining new (or patched) tools just because
we want to
avoid having the _possibility_ of long listings at any cost...

I remember
/proc/sys/net/ipv4/conf/
was broken for about >300 devices. I do not know how's it today.

> Adding the hashed lookup for devices took the exponential curve out of
> ip and ifconfig's performance, btw.

n^2 for creating n devices (in the unfortunate increasing or random
order),
(not 2^n), I guess.

    Cell

--
You'll never see all the places, or read all the books, but fortunately,
they're not all recommended.



