Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUBGV2v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 16:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265838AbUBGV2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 16:28:51 -0500
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78]:31192 "EHLO
	mta5.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265939AbUBGV2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 16:28:17 -0500
Date: Sat, 07 Feb 2004 16:29:36 -0500
From: Robert F Merrill <griever@t2n.org>
Subject: 2.6.2-mm1 won't compile (been doing this since 2.6.1-mm2 or so)
To: linux-kernel@vger.kernel.org
Message-id: <402558C0.5010100@t2n.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I upgraded to 2.6.1-mm4, I did the usual thing, copied my old 
.config from 2.6.1-mm1 and did make oldconfig.

However, when I run make, this happens:

include/asm/processor.h:68: error: `CONFIG_X86_L1_CACHE_SHIFT' 
undeclared here (not in a function)
include/asm/processor.h:68: error: requested alignment is not a constant
make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1


The only way I've found to fix this is to add a manual #define for this 
symbol to autoconf.h

The config option IS in i386/defconfig, but for some reason doesn't get 
put into .config

if I add it to .config manually, it gets removed when I run make (?!?).

I don't think this happens if I delete .config and make one from scratch.


