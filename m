Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965145AbWGKEjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbWGKEjl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWGKEjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:39:40 -0400
Received: from DSL135-086.labridge.com ([206.117.135.86]:27307 "EHLO 
	orion.sysdev.org") by vger.kernel.org with ESMTP id S965145AbWGKEjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:39:39 -0400
Date: Mon, 10 Jul 2006 20:39:38 -0800
From: Tony Borras <tonyb@thekrnl.sysdev.org>
To: linux-kernel@vger.kernel.org
Cc: gmorris@toyecorp.com
Subject: Memory tables corruption - kernel v2.4.33-rc1
Message-Id: <20060710203938.134a4d16.tonyb@sysdev.org>
Organization: SysDev Inc.
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux-2.6.5-SMP64
X-SlakBoot: SlakbootIBS v9.2.3
User-Agent: Sylpheed/0.9.4
X-Sylpheed-Rules: You Bet
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please fwd to 2.4.33 Team.

One of my customers reported in tests that, after some runtime,
his 59MB ram drive suddenly, randomly shrinks.

Same customer s/w has been running fine with 2.4.31 kernel.


Report follows:

I have two Advantech (i486 Geode's w/64MB ram, ~49MB usable, as
configured in the kernel make) test units where Dosemu crashed
this weekend. For some reason the Via unit was fine.

Here is what happened:

1. Linux was O.K., dosemu 1.3.2 had shut down.
It appears both units were out of RAM.

2. The first unit showed the RAM drive size to be
14661 1k blocks using the df command. The 1K blocks
should be 47595, as they were after boot. The other unit
showed the correct value of 1K blocks=47595. Even after
restarting the Advantech, the 1K blocks would not go back to
normal, so my software cannot even load.

3. The second Advantech unit showed correct values with the df
command, but when I used the du -cbs command, I found the /tmp
directory had only 110796 bytes, instead of the normal ~15 MB.
When I restarted Linux, all the RAM came back, and the
unit started working again.

                              ---------

Thanks, I will check further with this customer.

Tony Borras



Fall is my favorite season in Los Angeles, watching the birds
change color and fall from the trees.
   David Letterman (1947 - )

--
  __      __  _     I N C.               http://www.sysdev.org
/ __|\\// __||  \  __   __          /         tonyb@sysdev.org
\__ \ \/\__ \||)|/ O_)\/ /        \/  System Tools / Utilities
|___/ || ___/|_ /\___|\_/        WIntel / Linux Device Drivers

