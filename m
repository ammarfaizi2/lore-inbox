Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTACQII>; Fri, 3 Jan 2003 11:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267568AbTACQIH>; Fri, 3 Jan 2003 11:08:07 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267566AbTACQHv>;
	Fri, 3 Jan 2003 11:07:51 -0500
Date: Fri, 3 Jan 2003 08:13:22 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
In-Reply-To: <20030103093250.GC7661@sasa.home>
Message-ID: <Pine.LNX.4.33L2.0301030808460.32697-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jan 2003, SZALAY Attila wrote:

| Hi!
|
| On 2003 Jan 02, Randy.Dunlap wrote:
| >
| > Yes, unfortunately this is a well-known problem.
| > See kernel.bugzilla.org # 126 and # 164.
| >
| > You need to have CONFIG_INPUT=y, not =m.
|
| Thank you, it's work.
|
| But I have another problem.
|
| drivers/message/i2o/i2o_lan.c:28: #error Please convert me to Documentation/DMA-mapping.txt
| drivers/message/i2o/i2o_lan.c:119: parse error before `struct'
| drivers/message/i2o/i2o_lan.c: In function 	2o_lan_receive_post_reply':
| drivers/message/i2o/i2o_lan.c:385: `run_i2o_post_buckets_task' undeclared (first use in this function)
| drivers/message/i2o/i2o_lan.c:385: (Each undeclared identifier is reported only once
| drivers/message/i2o/i2o_lan.c:385: for each function it appears in.)
| drivers/message/i2o/i2o_lan.c: In function 	2o_lan_register_device':
| drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
| drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
| drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
| drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
| drivers/message/i2o/i2o_lan.c:1407: structure has no member named `sync'
| make[4]: *** [drivers/message/i2o/i2o_lan.o] Error 1
| make[3]: *** [drivers/message/i2o] Error 2
| make[2]: *** [drivers/message] Error 2
| make[1]: *** [drivers] Error 2

Yes, another known problem:
  http://bugme.osdl.org/show_bug.cgi?id=198

Do you have an I2O LAN device?
If so, what product is it?

Alan Cox has said that this isn't likely to get fixed because there are
either few or none of these devices.  I worked on one at Intel, but it
was never released as an I2O device, just using native proprietary
firmware.  Using I2O, it was dog slow.

-- 
~Randy

