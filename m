Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbSJMMlp>; Sun, 13 Oct 2002 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbSJMMlo>; Sun, 13 Oct 2002 08:41:44 -0400
Received: from [212.104.37.2] ([212.104.37.2]:52237 "EHLO
	actnetweb.activenetwork.it") by vger.kernel.org with ESMTP
	id <S261509AbSJMMlK>; Sun, 13 Oct 2002 08:41:10 -0400
Date: Sun, 13 Oct 2002 14:18:07 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: johannes@erdfelt.com, greg@kroah.com
Subject: [2.5.42][USB] Sleeping in illegal context
Message-ID: <20021013121807.GA527@dreamland.darkstar.net>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get the following debug messages during boot, at USB initialization:

Debug: sleeping function called from illegal context at
include/asm/semaphore.h:119
Call Trace:
 [<c0253cc2>] usb_hub_events+0x72/0x3b0
 [<c0116533>] schedule+0x183/0x300
 [<c011d4e4>] reparent_to_init+0xe4/0x180
 [<c0254035>] usb_hub_thread+0x35/0xf0
 [<c0116710>] default_wake_function+0x0/0x40
 [<c0254000>] usb_hub_thread+0x0/0xf0
 [<c0105641>] kernel_thread_helper+0x5/0x14


Kernel is UP with CONFIG_PREEMPT=y

ciao,
Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
