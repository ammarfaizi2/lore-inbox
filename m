Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265259AbRFUWOF>; Thu, 21 Jun 2001 18:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265260AbRFUWNp>; Thu, 21 Jun 2001 18:13:45 -0400
Received: from hercules.telenet-ops.be ([195.130.132.33]:15234 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S265259AbRFUWNj>;
	Thu, 21 Jun 2001 18:13:39 -0400
Message-ID: <3B3270C4.3080103@pandora.be>
Date: Fri, 22 Jun 2001 00:10:12 +0200
From: Guy Van Den Bergh <guy.vandenbergh@pandora.be>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i586; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org, Holger Kiehl <Holger.Kiehl@dwd.de>,
        "David S. Miller" <davem@redhat.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: [Vlan-devel] Should VLANs be devices or something else?
In-Reply-To: <Pine.LNX.4.30.0106191016200.27487-100000@talentix.dwd.de> <3B2FCE0C.67715139@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Maybe this has been discussed already, but what about integration
with the bridging code? Is it possible to add add a vlan interface to a 
bridge? In other words, can you bridge between one or more regular 
interfaces and a vlan?

Regards,
Guy

Ben Greear wrote:

> I have had a good discussion with Dave Miller today, and there
> is one outstanding issue to clear up before my 802.1Q VLAN patch may
> be considered for acceptance into the kernel:
> 
> Should VLANs be devices or some other thing?
> 
> I strongly feel that they should be devices for many reasons.
> 
> 1)  It makes integration with user-space tools (ip, ifconfig, arp...) a non-issue.
> 
> 2)  It is logically correct, a VLAN is a (net_)device and in all ways acts like one.
> 
> 3)  It introduces no fast-path performance degradation that I know of.  The one
>     slow path involves the linear lookup of a device by name (or id??).  This can
>     be fixed by hashing the list, if needed.
> 
> 4)  Both VLAN patches have used VLANs-as-devices from the beginning, and have
>     seen no ill affects to this approach that would be mitigated by some other
>     architecture.
> 
> However, we need the community as a whole to agree more-or-less that my
> (and others who share them) arguments are sound.  So please, bring your
> complaints fowards now...or forever patch by hand!
> 
> Also, any other complaints or suggestions for the VLAN code should be
> mentioned too, of course!
> 
> If you wish to view the patch, get the 1.0.1 release from my vlan page:
> http://scry.wanfear.com/~greear/vlan.html
> I will release a new one shortly with the fast-dev-lookup code
> (which is already #ifdef'd out) completely removed, as per Dave's
> wish.
> 
> Thanks,
> Ben
> 
> 


