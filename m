Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUBFRde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265547AbUBFRde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:33:34 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:32109 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265538AbUBFRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:33:33 -0500
Message-ID: <4023D098.1000904@myrealbox.com>
Date: Fri, 06 Feb 2004 09:36:24 -0800
From: walt <wa1ter@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.6) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [2.6.1] Kernel panic with ppa driver updates
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This panic started with the bk changesets applied by Linus yesterday.

The ppa driver works fine when compiled as a module, but when compiled in
I get this during boot:

ppa_pb_claim+0x7b/0x80
__ppa_attach+0x137/0x350
ppa_wakeup+0x0/0x70
autoremove_wake_function+0x0/0x50 [this line appears twice]
parport_register_driver+0x36/0x70
ppa_driver_init+0x23/0x30
do_initcalls+0x2c/0xa0
init_workquese+0xf/0x30
init+0x32/0x140
init+0x0/0x140
kernel_thread_helper+0x5/0xc

Code: c7 80 24 01 00 00 01 00 00 c3 8b 42 50 b9 01 00 00 00 ba
<0>Kernel panic: attempted to kill init!

When compiling ppa.c I see this warning:
in __ppa_attach 'ports' might be used unitialized

Please let me know if you need more information.

