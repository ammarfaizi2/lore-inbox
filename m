Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbTGEV1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 17:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266501AbTGEV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 17:27:04 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:1463
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S266498AbTGEV1C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 17:27:02 -0400
Message-ID: <3F0745EC.1060204@candelatech.com>
Date: Sat, 05 Jul 2003 14:41:00 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jeff Sipek <jeffpc@optonline.net>,
       Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net.sgi.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, netdev@oss.sgi.com
Subject: Re: [PATCH - RFC] [1/5] 64-bit network statistics - generic net
References: <E19YtAq-0006Xf-00@calista.inka.de> <200307051637.52252.jeffpc@optonline.net> <3F0737D1.5090109@pobox.com>
In-Reply-To: <3F0737D1.5090109@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> The net stats are already unsigned long internally.
> 
> 64-bit case is handled quite nicely today, thanks :)
> 
> I'm such a 64-bit bigot that "buy a 64-bit computer" is a solution I 
> commonly suggest, and it seems to fit well here, too.
> 
>     Jeff, wondering if Intel will bother to compete w/ Athlon64

Untill the net-stats are 64-bit on 32-bit systems, we will need some
way to know if they have wrapped or not when reading from nettool
and getting 64-bit numbers.

I guess what I really mean to say is that, if nettool is returning 64-bit
values, we need to know which ones are obtained from 32-bit counters.
32 -> 64 bit mapping will require wrap handling on low 32-bits, but
64 -> 64 bit mapping will require wrapping about 4-billion times less often :)

Perhaps a precision field is also needed for backwards/forwards compatability,
and perhaps a nettool version field as well to also help with backwards/forwards
compat.

Ben

> 
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


