Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267604AbSIRQqz>; Wed, 18 Sep 2002 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbSIRQqy>; Wed, 18 Sep 2002 12:46:54 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:34198 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267604AbSIRQqV>;
	Wed, 18 Sep 2002 12:46:21 -0400
Message-ID: <3D88AF06.7060108@candelatech.com>
Date: Wed, 18 Sep 2002 09:51:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Pommnitz <pommnitz@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Networking:  send-to-self
References: <20020918134907.13218.qmail@web13308.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Pommnitz wrote:
> Hi Ben,
> I had the exact same problem in March (see 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=101679264814811&w=2). The 
> hacky solution I came up with was to use the following NAT rule:
> 
> iptables -t nat -A POSTROUTING -o eth0 -d 10.1.12.151 -p udp --dport 12345
> -j SNAT --to 1.2.3.4
> 
> This way the packets claimed to come from a foreign IP address and were 
> accepted. However, when the packets hit an ingress filter on their way,
> this will fail. 
> 
> Will you push this to DaveM for inclusion?

Dave has the link to the patch, but whether or not he will include
it in the kernel proper I do not know.  I hope he does, of course.

Ben

> 
> Regards
>   Jörg
> 
> =====


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


