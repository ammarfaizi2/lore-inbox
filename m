Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129774AbRAGSvc>; Sun, 7 Jan 2001 13:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRAGSvX>; Sun, 7 Jan 2001 13:51:23 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:63757 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129774AbRAGSvP>;
	Sun, 7 Jan 2001 13:51:15 -0500
Message-ID: <3A58C97B.A3C5676B@candelatech.com>
Date: Sun, 07 Jan 2001 12:54:35 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
CC: "David S. Miller" <davem@redhat.com>, ak@suse.de,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumissionpolicy!)
In-Reply-To: <Pine.GSO.4.30.0101071026070.18916-100000@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:

> So instead of depending what ifconfig does, maybe a better test for Ben is
> to measure the kernel level improvement in the lookup for example from
> 2..6000 devices.

In the benchmark I gave, the performance increase was in the kernel,
not user space, and it was more than 10 times faster, at least with 4k
VLANs.  Adding VLANs was about twice as fast, and deleting them was
faster, though not as much.

 Tests with the user space tools will also help. example
> to add to Andi's flavor:
> "date; time ifconfig -a; date" for each number of devices.
> repeat for ip as well ;->

I can show a range w/out much trouble.  I think I'll also tweak
the hash code to just do linear lookups if the number of interfaces
is below some number, (probably 20, or whatever the numbers show
is good...)

Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
