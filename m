Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbREQQEk>; Thu, 17 May 2001 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261959AbREQQEU>; Thu, 17 May 2001 12:04:20 -0400
Received: from ws130.nomadiclab.com ([195.165.196.130]:60687 "HELO
	ws130.nomadiclab.com") by vger.kernel.org with SMTP
	id <S261960AbREQQEN>; Thu, 17 May 2001 12:04:13 -0400
Date: Thu, 17 May 2001 19:04:06 +0300 (EEST)
From: Teemu Rinta-aho <teemu.rinta-aho@nomadiclab.com>
To: <linux-kernel@vger.kernel.org>
Subject: IPv6 and multiple interfaces
Message-ID: <Pine.LNX.4.33.0105171856370.30834-100000@ws142.nomadiclab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running kernel 2.4.3 and I have run into problems
with IPv6 when I want to use more than one network interface
card simultaneously. IPv6 works fine with one interface
but when I add another, it starts dropping packets on
the first interface. This seems to be related with
incoming Router Advertisement messages on the other
interface. About 50% of the packets in ping6 start to
get dropped after I put the other interface up.

I have added myself a small patch in ndisc.c so that
there is only one default route in the routing table
at any time. Without that things work even worse.

I have not figured out what makes IPv6 drop packets.
I would really appreciate if someone who knows
Linux IPv6 code would contact me.

BR,
Teemu

-- 

-----------------------------------------------------------
Teemu Rinta-aho                        teemu@nomadiclab.com
NomadicLab, Ericsson Research               +358 9 299 3078
FIN-02131 Espoo, Finland                   +358 40 562 3066
-----------------------------------------------------------

