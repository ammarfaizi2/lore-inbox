Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264393AbTDXEiN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTDXEiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:38:13 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:33197 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S264393AbTDXEiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:38:11 -0400
Date: Wed, 23 Apr 2003 21:50:00 -0700
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.68
Message-Id: <20030423215000.71bb1ef2.randy.dunlap@verizon.net>
In-Reply-To: <20030422115905.780cd1df.rddunlap@osdl.org>
References: <20030422115905.780cd1df.rddunlap@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [4.64.197.106] at Wed, 23 Apr 2003 23:50:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| 
| 45 functions for 2.5.68, 44 for 2.5.67. The new one is this:
| 0xc0881136 mxb_init_done:                      sub    $0x51c,%esp
| 
| Michael, are there any reasons not to make saa7740_init static, global
| or both? The memory is gone forever either way.
| Moreover, wouldn't this be a candidate for __init and __initdata
| respectively?
| 
| Apart from that, patches for the marked (P) functions are in -je1, but
| might need some shaping up. Handle with care.
| 
| Everything else remains unchanged since 2.5.67.
| 
| 0xc05cff3c parport_config:                     sub    $0x490,%esp
| 0xc0c12366 sw_connect:                         sub    $0x490,%esp
| 0xc0c36c73 ixj_config:                         sub    $0x484,%esp
| 0xc0c18ef1 uinput_alloc_device:                sub    $0x480,%esp

For PCMCIA/PC Card drivers (parport and ixj above), what context do the
pcmcia event handlers run in?  Can they kmalloc()?  with what gfp_flags?

I'll post patches for sw_connect() and uinput_alloc_device() shortly.

-- 
~Randy
