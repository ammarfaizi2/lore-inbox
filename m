Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287769AbSANRMc>; Mon, 14 Jan 2002 12:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSANRMX>; Mon, 14 Jan 2002 12:12:23 -0500
Received: from ns.ithnet.com ([217.64.64.10]:12302 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S287764AbSANRMS>;
	Mon, 14 Jan 2002 12:12:18 -0500
Date: Mon, 14 Jan 2002 18:12:10 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Memory problem with bttv driver
Message-Id: <20020114181210.67650995.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

yesterday we came across another MM related problem. This time its related to
the bttv-driver. We do very simple things:

First load it:

# modprobe bttv
Jan 14 17:28:14 fred kernel: bttv: driver version 0.7.83 loaded
Jan 14 17:28:14 fred kernel: bttv: using 2 buffers with 2080k (4160k total) for
capture Jan 14 17:28:14 fred kernel: bttv: Host bridge is VIA Technologies,
Inc. VT82C693A/694x [Apollo PRO133x] Jan 14 17:28:14 fred kernel: bttv: Host
bridge is VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] Jan 14 17:28:14
fred kernel: bttv: Bt8xx card found (0). Jan 14 17:28:14 fred kernel: bttv0:
Bt848 (rev 18) at 00:0c.0, irq: 16, latency: 32, memory: 0xef000000 Jan 14
17:28:14 fred kernel: bttv0: using: BT848A( *** UNKNOWN/GENERIC **)
[card=0,autodetected] Jan 14 17:28:14 fred kernel: i2c-core.o: adapter bt848 #0
registered as adapter 0. Jan 14 17:28:14 fred kernel: bttv0: i2c: checking for
MSP34xx @ 0x80... not found Jan 14 17:28:14 fred kernel: bttv0: i2c: checking
for TDA9875 @ 0xb0... not found Jan 14 17:28:14 fred kernel: bttv0: i2c:
checking for TDA7432 @ 0x8a... not found Jan 14 17:28:14 fred kernel:
i2c-core.o: driver i2c TV tuner driver registered. Jan 14 17:28:14 fred kernel:
tuner: chip found @ 0xc2 Jan 14 17:28:14 fred kernel: bttv0: i2c attach
[client=(unset),ok] Jan 14 17:28:14 fred kernel: i2c-core.o: client [(unset)]
registered to adapter [bt848 #0](pos. 0).

Then try to use it:

# xawtv
Jan 14 17:46:53 fred kernel: bttv: vmalloc_32(4259840) failed

... and exit of course.

Uh?
Interesting about it:
Does not work with 2.4.17 nor 2.4.18-pre3, but does work with 2.4.10-SUSE.
(Same setup, only booting another kernel)

Any hints?

Regards,
Stephan
