Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUHNRCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUHNRCp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUHNRCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 13:02:45 -0400
Received: from gateway.nixsys.be ([195.144.77.33]:9740 "EHLO gateway.nixsys.be")
	by vger.kernel.org with ESMTP id S264213AbUHNRCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 13:02:43 -0400
Subject: Issue with i82365 PCMCIA controller in 2.6.8.1
From: Wouter Verhelst <wouter@grep.be>
Reply-To: wouter@grep.be
To: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Grep.be -- Grep the Internet :-)
Message-Id: <1092502955.2228.6.camel@rock.grep.be>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 14 Aug 2004 19:02:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just compiled 2.6.8.1 for my system, and found the following in dmesg:

-----
Intel ISA PCIC probe: not found.
Device 'i823650' does not have a release() function, it is broken and must be fixed.
Badness in device_release at drivers/base/core.c:85
 [<c01ac814>] kobject_cleanup+0x94/0xa0
 [<c033b973>] init_i82365+0x1a3/0x1c0
 [<c032678c>] do_initcalls+0x2c/0xc0
 [<c01003f0>] init+0x0/0xf0
 [<c010041a>] init+0x2a/0xf0
 [<c0102298>] kernel_thread_helper+0x0/0x18
 [<c010229d>] kernel_thread_helper+0x5/0x18
-----

... which reminded me that I still had this in my .config (the card
isn't in there anymore since quite a while now, so the failure to find
it is expected).

Apologies if this has already been reported, but googling didn't reveal
anything.

-- 
         EARTH
     smog  |   bricks
 AIR  --  mud  -- FIRE
soda water |   tequila
         WATER
 -- with thanks to fortune

