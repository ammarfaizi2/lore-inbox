Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbRFSXRX>; Tue, 19 Jun 2001 19:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264831AbRFSXRM>; Tue, 19 Jun 2001 19:17:12 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:54468 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S264830AbRFSXQ5>;
	Tue, 19 Jun 2001 19:16:57 -0400
Message-ID: <3B2FDD62.EFC6AEB1@candelatech.com>
Date: Tue, 19 Jun 2001 16:16:50 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Dax Kelson <dkelson@gurulabs.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: Should VLANs be devices or something else?
In-Reply-To: <3B2FCE0C.67715139@candelatech.com>
		<Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com> <15151.55017.371775.585016@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Dax Kelson writes:
>  > On Tue, 19 Jun 2001, Ben Greear wrote:
>  > > Should VLANs be devices or some other thing?
>  >
>  > I would vote that VLANs be devices.
>  >
>  > Conceptually, VLANs as network devices is a no brainer.
> 
> Conceptually, svr4 streams are a beautiful and elegant
> mechanism. :-)
> 
> Technical implementation level concerns need to be considered
> as well as "does it look nice".

I found it to be the easiest way to implement things.  It allowed
me to not have to touch any of layer 3, and I did not have to patch
any user-space program like ip or ifconfig.

I'm not even sure if the nay-sayers ever had another idea, they
just didn't like having lots of interfaces.  Originally, there
were claims of inefficiency, but it seems that other than things
like 'ip' and ifconfig, there are no serious performance problems
I am aware of.


Adding the hashed lookup for devices took the exponential curve out of
ip and ifconfig's performance, btw.


-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
