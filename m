Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263606AbUAYCmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 21:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUAYCmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 21:42:46 -0500
Received: from tekla.ing.umu.se ([130.239.117.80]:11216 "EHLO tekla.ing.umu.se")
	by vger.kernel.org with ESMTP id S263606AbUAYCmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 21:42:44 -0500
Date: Sun, 25 Jan 2004 03:42:38 +0100
From: Tomas Ogren <stric@ing.umu.se>
To: linux-kernel@vger.kernel.org
Subject: Fried the onboard Broadcom 4401 network...
Message-ID: <20040125024238.GA10424@ing.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-System: Linux tekla 2.4.24-rc1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm not exactly sure what caused this or if it's reproducable, but
here's my story anyway.

I have an ASUS A7V8X with onboard Broadcom 4401 (Rev 01) 10/100 and I've
been running 2.4.x (2.4.21) for a long time now with Broadcoms bcm4400
driver (v2.0.2) which has worked just fine. Now I decided to try 2.6 and
installed 2.6.2-rc1-bk2 with the b44 driver that comes with the kernel.
While doing some tests I noticed that I got really crappy performance
(3-4MB/s) while sending, but full throughput (~11MB/s) while receiving.

So I figured that it could be the shipped driver.. Downloaded bcm4400
v3.0.7 which has 2.6 support and installed it. Didn't make stuff go
faster. So I thought I'd boot into 2.4.25pre6 and see how it behaves
under a 2.4 kernel with the latest bcm4400 driver. The 2.4.25pre6 I had
compiled includes the b44 driver. I booted it up and then I got a bunch
of the following:
"eth0: b44: BUG!  Timeout waiting for bit 80000000 of register 428 to
clear."
followed by:
"eth0: Link is down."

After that, I have not been able to get link (neither see it through
Linux/WinXP or the physical LED). I have tried multiple cables and my
laptop is perfectly happy with all of them, but the broadcom thingie
seems not. The switch doesn't see link either.

The actual chip seems to be alive, it responds to PCI stuff... it can be
initialized and all but I can't get link.

Not sure what you can do with this information, but I can probably not
do anything more with this NIC at least..

CC me for any replies, please.

/Tomas
-- 
Tomas Ögren, stric@ing.umu.se, http://www.ing.umu.se/~stric/
|- Student at Computing Science, University of Umeå
`- Sysadmin at {cs,ing,acc}.umu.se
