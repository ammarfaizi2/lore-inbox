Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271729AbTGRHLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 03:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271730AbTGRHLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 03:11:10 -0400
Received: from outbound02.telus.net ([199.185.220.221]:36040 "EHLO
	priv-edtnes04.telusplanet.net") by vger.kernel.org with ESMTP
	id S271729AbTGRHLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 03:11:06 -0400
Subject: Update to Firewire not happy in 2.6-test1
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1058513239.6436.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 18 Jul 2003 01:27:19 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is just an update to Ben Collins and others who are working on
Firewire in 2.6-test1.  Firewire is still not a happy camper (I will be
looking for patches as they are submitted so as to provide hopefully
useful feedback.  In case it wasn't obvious, my firewire card is driven
by:
00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev 43)
and the controllers on my external firewire drive bays are driven by
Oxford Semi '900 chips.
The following is a nasty message I got after booting:


Red Hat Linux release 9 (Shrike)
Kernel 2.6.0-test1 on an i686
                                                                                                         
localhost login: root
Password: Slab corruption: start=d552d8c0, expend=d552d937,
problemat=d552d900
Last user: [<f891d1fd>](free_hpsb_packet+0x2c/0x33 [ieee1394])
Data: ****************************************************************6A
******************************************************A5
Next: 71 F0 2C .FD D1 91 F8 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was
modified after freeing
Call Trace:
 [<c014e5b1>] check_poison_obj+0x16c/0x1ac
 [<c014e77d>] slab_destroy+0x18c/0x194
 [<c0152532>] cache_reap+0x2d6/0x45c
 [<c01515ef>] reap_timer_fnc+0x0/0x29
 [<c01515fa>] reap_timer_fnc+0xb/0x29
 [<c012df3b>] update_wall_time+0xf/0x3a
 [<c012e26c>] run_timer_softirq+0x18b/0x429
 [<c01127e7>] timer_interrupt+0x17f/0x3be
 [<c0129051>] do_softirq+0xa1/0xa3
 [<c010cc2f>] do_IRQ+0x256/0x3a4
 [<c0124dc7>] profile_hook+0x2f/0x4d
 [<c0107269>] default_idle+0x0/0x2c
 [<c0107269>] default_idle+0x0/0x2c
 [<c010ab70>] common_interrupt+0x18/0x20
 [<c0107269>] default_idle+0x0/0x2c
 [<c0107269>] default_idle+0x0/0x2c
 [<c0107290>] default_idle+0x27/0x2c
 [<c0107301>] cpu_idle+0x31/0x3a
 [<c0105000>] rest_init+0x0/0xf5
 [<c0398725>] start_kernel+0x1b8/0x210
 [<c039843f>] unknown_bootoption+0x0/0xfa

This e-mail is meant to be useful.  If you need more information, please
do not hesitate to ask.

Thanks, 

Bob
-- 
Bob Gill <gillb4@telusplanet.net>

