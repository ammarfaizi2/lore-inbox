Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264770AbUG2Qsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbUG2Qsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267604AbUG2QrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:47:13 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:13073 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267567AbUG2Qpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:45:36 -0400
Message-ID: <b71082d8040729094537e59a11@mail.gmail.com>
Date: Thu, 29 Jul 2004 18:45:35 +0200
From: Bart Alewijnse <scarfboy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: gigabit trouble
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought two rtl8169 cards, and am having a little trouble.

Setup: 
--
Old computer: Celeron 400, 8139 nic, 8169 nic
New computer: XP 1700, 8139 nic, 8169 nic

The 8139 (100mbit)'s are for internet access, their wires head out to
the switch - the gbit is purely point to point and uses a private
network. (192.168 etc)

I run gentoo on both, which until yesterday was 2.6.7-ck5 (on both),
and currently run 2.6.7-mm6 (again, both), as I saw the suggestion
somewhere it had better support for the card - something about a new
net card inferface that's nicer to interrupts.
--


There's a speed increase, from ~4mb in samba and ~6mb in nfs on my
100mbit cards to a more hard drive flutter limited ~8 to 10.5MB/s on
both.

First problem - that sounds suspiciously like it's hanging around the
100mbit limit. I've squeezed a cable the way
http://www.sql-server-performance.com/jc_gigabit.asp
suggests, and when I run my new computer under winXP, it reports the
link speed as 1gbit; also, it's using the gbit cards for transfer,
I've yanked cables to test.

So, question one - how do I see the link speed under linux, and how,
if at all, do I control it?

(Plus possibly - what's the name of a good non-service direct-network
throughput tester, preferable one that also runs on windows)




Second problem - when doing speed tests (dd if=mounted_remote_nfs file
of=local_dev_null bs=10M or the like) my new computer makes funny
noises when doing a 10MB/s transfer. The sound seems to come from the
power supply, of all things. It's a 450watt, which is 100W more than
was previously enough; and I'm temporarily using an ancient TNT for a
vid card. It's not power amount, though possibly power purity and
distribution; it was a relatively cheap power supply. (But then again
- that shouldn't have -this- effect, should it?)

Disturbingly, in such a linux-to-linux speed test, my new computer
froze.As in, in text mode, have the screen freeze and apparently be
half written full of nonsense.

Whereas my old computer, which was doing the exact same thing except
it was sending (and remember, this computer is about a third the cpu
speed) said 10MB/s, lived happily.

What's even stranger is that I don't have this problem - noise or
freezing - when I run my new computer in winXP, where I get
approximately the same speed.

It can't be the power supply as winxp works on the same system and setup;
it can't be a simple case of driver trouble, as the old computer works
with the same driver and card.

The only thing I can think of is my motherboard - it's given me pci
transfer troubles before; I have to hit an exact permutation of
inserted cards to have, say, my sound, network and tv card work
simultaneously in winxp -or- linux. But even that's not the exact
problem right now, as it's the same hardware setup that froze linux
but not xp.

So, question two - what possibly happened there?  Is this a
driver/motherboard coincidence and therefore quite doomed?

Quite frankly, I'm stumped. Any suggestions are welcome.


--Bart Alewijnse
