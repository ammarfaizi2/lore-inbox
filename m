Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSIDWOl>; Wed, 4 Sep 2002 18:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSIDWOl>; Wed, 4 Sep 2002 18:14:41 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:62680 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S315472AbSIDWOk>;
	Wed, 4 Sep 2002 18:14:40 -0400
Date: Wed, 4 Sep 2002 15:18:53 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Irq handler reentrancy ?
Message-ID: <20020904221853.GB21494@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Just a quick question : can an interrupt handler be preempted
or reenter itself ?
	I know that it can execute in parallel on the various CPUs, so
require spin_lock protection. However, on 2.5.32 I see weird bugs that
lead me to believe that the irq handler is interrupted at the point
where a new hardware interrupt is generated (for example, after
clearing the previous irq or after setting the new irq mask). The box
just freezes, without giving any Opps or anything on the serial
console. Of course, any attempt to add relevant printks make the bug
goes away, so it's impossible to debug.
	2.4.20 runs fine.

	Thanks...

	Jean
