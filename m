Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263292AbRFJXsp>; Sun, 10 Jun 2001 19:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbRFJXsf>; Sun, 10 Jun 2001 19:48:35 -0400
Received: from m241-mp1-cvx1c.col.ntl.com ([213.104.76.241]:7040 "EHLO
	[213.104.76.241]") by vger.kernel.org with ESMTP id <S263218AbRFJXsY>;
	Sun, 10 Jun 2001 19:48:24 -0400
To: <perex@suse.cz>
Cc: Robin Cull <kernel-list@phaderunner.demon.co.uk>,
        <linux-kernel@vger.kernel.org>
Subject: 2.4.4 isapnp - wrong set of resources chosen
From: John Fremlin <vii@users.sourceforge.net>
Date: 11 Jun 2001 00:47:46 +0100
Message-ID: <m23d97aod9.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi!

Robin Cull and I have OPL3-SA2 isapnp cards. Sometimes we get assigned
the wrong resource set. These cards do not take kindly to Alternate
resources 0:1 Priority acceptable, in fact they are completely broke,
so it is important to us that they get their first choice ;-)

The trouble is that isapnp auto conf does not always take the first
choice, even when it is available! This happens to me everytime I
unload and reload the opl3sa2 module, but can also be seen after
unloading the module by doing

card 0 YMH0020
dev 0 YMH0021
deactivate
auto
activate

The second config is chosen (see attached /proc/isapnp). However,
activating the first config by hand works fine - on reloading the
module it plays sounds just dandy.

card 0 YMH0020
dev 0 YMH0021
deactivate
port 0 0x220
port 1 0x530
port 2 0x388
port 3 0x330
port 4 0x370
dma 0 0
dma 1 1
irq 0 5
activate


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=isapnp


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=ioports


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=interrupts


--=-=-=


-- 

	http://ape.n3.net

--=-=-=--
