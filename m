Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVFQWgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVFQWgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFQWgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:36:40 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:44248 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261222AbVFQWgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:36:31 -0400
Message-ID: <42B35069.9010202@g-house.de>
Date: Sat, 18 Jun 2005 00:36:25 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: forcedeth as a module only?
References: <200506171804.j5HI4qoh027680@dbl.q-ag.de> <42B31749.90208@g-house.de> <42B336FC.9000400@colorfullife.com> <42B34D12.70008@g-house.de>
In-Reply-To: <42B34D12.70008@g-house.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau schrieb:
> Manfred Spraul schrieb:
>>
>>Could you try the attached patch? It polls for link changes instead of
>>relying on the irq. Additionally, I have enabled some debug output.

oh jolly, i think it worked!

eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
netconsole: device eth0 not up yet, forcing it
eth0: no link detected by phy - falling back to 10HD.
eth0: no link during initialization.
eth0: nv_update_linkspeed: PHY advertises 0x0de1, lpa 0x41e1.
eth0: changing link setting from 66536/0 to 65636/1.
eth0: link up.
netconsole: network logging started
[...]
eth0: nv_update_linkspeed: PHY advertises 0x0de1, lpa 0x41e1.
...

the last line gets repeated a couple of times, that must be the printk you
enabled.

thank you!
Christian.

(it's always stunning how a bugreport with that sparse details can lead to
a working kernel patch. cool.)
-- 
BOFH excuse #303:

fractal radiation jamming the backbone
