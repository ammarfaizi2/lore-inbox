Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSIOUgA>; Sun, 15 Sep 2002 16:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSIOUgA>; Sun, 15 Sep 2002 16:36:00 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:40676 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S318253AbSIOUgA>;
	Sun, 15 Sep 2002 16:36:00 -0400
Message-ID: <3D84F043.1070409@candelatech.com>
Date: Sun, 15 Sep 2002 13:40:35 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Enable sending network traffic to local machine over
 external interfaces.
References: <Pine.GSO.4.30.0209151616280.22001-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> What bad stuff are you smoking lately? Trying to turn linux into a traffic
> generator OS? ;-> Havent you been accused of that already?
> Actually, this is probably one of the few times i agree with you because i
> may have use for this; i dont think the maintainers may. Infact i think
> you are just about to be shot.
> How about putting ifdefs so that the code only gets activated if
> packetgen is active?
> 
> cheers,
> jamal
> 

Pktgen is independent of this particular hack.  One of the flag #defines is in the
patch to make my life easier, but it can be removed if that makes someone happier...

Right now, I am getting panics after 30 minutes running at around 250Mbps of tcp traffic to
myself over GigE nics.  But, I'm running NAPI e1000, the send-to-self hack, and
had the pktgen module loaded....  Trying to narrow it down...but so far, it looks
like memory corruption, perhaps somewhere in tcp/ip...

It can still be #ifdef'd, but some of the code just fixes the SO_BINDTODEVICE
feature, so I think that may be worth putting in anyway...

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


