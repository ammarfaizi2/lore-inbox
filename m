Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbTIEDVd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 23:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTIEDVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 23:21:32 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:44805 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261713AbTIEDVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 23:21:31 -0400
Date: Thu, 4 Sep 2003 20:21:00 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: cpu not being found by 2.6.0-test4, input event bug too
Message-ID: <20030905032100.GA32489@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	Can anyone think of a change that went in recently to the 2.6.0-test*
tree that could have caused one of my CPUs to not be detected by the kernel?
It's a dual P2/333 system based on an Intel 440DX chipset, don't remember
the exact model of the motherboard off-hand.  The latest BIOS update (rather
old) has been installed on the system already.

	Debian/woody-based system.

The dmesg is also being FLOODED with the following:
barbeque/kittens:doc: dmesg|head -2 ; dmesg | tail -2
ue: 0
evbug.c: Event. Dev: isa0060/serio1/input0, Type: 2, Code: 0, Value: -3
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 1, Code: 28, Value: 1
evbug.c: Event. Dev: isa0060/serio0/input0, Type: 0, Code: 0, Value: 0

As you can see from the truncation, the kernel buffer's being wrapped.
Once I get a login prompt and hop in, that's all there is.  The dmesg
saved by the init scripts in /var/log/dmesg is also filled with just that.

tail -f'ing the syslog file when I was still enabling the logging of that
from evbug.c:evbug_event() pretty much scrolled by looking like a pretty
text flood.

	As there's a TON of information, I put the config and other stuff
on the 'net at:

http://www.net-ronin.org/~ramune/kconf

-- DN
Daniel
