Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265628AbSKKHPK>; Mon, 11 Nov 2002 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265631AbSKKHPJ>; Mon, 11 Nov 2002 02:15:09 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:4480 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S265628AbSKKHPI>; Mon, 11 Nov 2002 02:15:08 -0500
Date: Mon, 11 Nov 2002 18:21:41 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.47 / pcmcia xircom eth oops
Message-ID: <20021111072141.GA584@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a dual eth+ser 16bit xircom card. it's detected ok and ttyS15 and
eth1 are created by the kernel just fine. On ejection though I get an
oops:

Badness in put_device at drivers/base/core.c:211
Call Trace:
 [<c022e8a8>] put_device+0x9c/0xbc
 [<c01e80e6>] pci_remove_device+0xe/0x38
 [<c02850d7>] cb_free+0x27/0x5c
 [<c028258a>] shutdown_socket+0x76/0xe0
 [<c02828b5>] do_shutdown+0x5d/0x64
 [<c02828f6>] parse_events+0x3a/0xd8
 [<c028705e>] yenta_bh+0x3e/0x44
 [<c0127cb1>] worker_thread+0x1e9/0x2cc
 [<c0127ac8>] worker_thread+0x0/0x2cc
 [<c0287020>] yenta_bh+0x0/0x44
 [<c0117a30>] default_wake_function+0x0/0x34
 [<c0117a30>] default_wake_function+0x0/0x34
 [<c0106e59>] kernel_thread_helper+0x5/0xc

Badness in put_device at drivers/base/core.c:211
Call Trace:
 [<c022e8a8>] put_device+0x9c/0xbc
 [<c01e80e6>] pci_remove_device+0xe/0x38
 [<c02850d7>] cb_free+0x27/0x5c
 [<c028258a>] shutdown_socket+0x76/0xe0
 [<c02828b5>] do_shutdown+0x5d/0x64
 [<c02828f6>] parse_events+0x3a/0xd8
 [<c028705e>] yenta_bh+0x3e/0x44
 [<c0127cb1>] worker_thread+0x1e9/0x2cc
 [<c0127ac8>] worker_thread+0x0/0x2cc
 [<c0287020>] yenta_bh+0x0/0x44
 [<c0117a30>] default_wake_function+0x0/0x34
 [<c0117a30>] default_wake_function+0x0/0x34
 [<c0106e59>] kernel_thread_helper+0x5/0xc

cs: cb_free(bus 2)

this is with the new tulip xircom driver. I received no oopses when I
wasn't using the xircom eth drivers. the eth1 interface was not defined
at the time.

if you need more info, holler.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
