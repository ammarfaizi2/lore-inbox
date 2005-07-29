Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVG2IFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVG2IFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 04:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262505AbVG2IFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 04:05:44 -0400
Received: from blackhole.adamant.net ([212.26.128.69]:15395 "EHLO
	blackhole.adamant.ua") by vger.kernel.org with ESMTP
	id S262499AbVG2IFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 04:05:41 -0400
Date: Fri, 29 Jul 2005 11:05:40 +0300
From: Alexander Trotsai <mage@adamant.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: routing/shaping vs smp
Message-ID: <20050729080540.GG3990@blackhole.adamant.ua>
References: <20050728161317.GE3990@blackhole.adamant.ua> <Pine.LNX.4.61.0507290941330.26861@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507290941330.26861@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm have one gigabit nic with static IRQ (2,000/s)
I have very high CPU load from HTB shaping I think
Now I have near 80Mbit traffic going throw my shaper (IMQ,
two interfaces) and 50-70% CPU in system (now P4 3.0GHz)
So I can't install really powerfull cpu (I don't know which
cpu is really more powerfull)
So I think about SMP
2.4 can't use second (and other proccessors) for
routing/shaping
Is 2.6 do?

On Fri, Jul 29, 2005 at 09:42:50AM +0200, Jan Engelhardt wrote:
JE> >Hi
JE> >
JE> >Is that possible use power of 2 or more CPU (smp) for
JE> >routing/shaping/accounting (iptables rules) with 2.4.x or
JE> >may be 2.6.x linux kernel?

JE> Incoming packets are handled in an interrupt. So if you can manage to 
JE> distribute IRQs between CPUs, you can at least split the routing work
JE> per NIC, e.g. cpu0 for eth0, cpu1 for eth1.


JE> Jan Engelhardt
JE> -- 

-- 
Best regard, Aleksander Trotsai aka MAGE-RIPE aka MAGE-UANIC
My PGP key at ftp://blackhole.adamant.ua/pgp/trotsai.key[.asc]
Big trouble - Insert coin for new game
