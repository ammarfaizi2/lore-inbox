Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSI3Pku>; Mon, 30 Sep 2002 11:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262057AbSI3Pku>; Mon, 30 Sep 2002 11:40:50 -0400
Received: from ns.suse.de ([213.95.15.193]:57101 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261829AbSI3Pkt>;
	Mon, 30 Sep 2002 11:40:49 -0400
Date: Mon, 30 Sep 2002 17:46:14 +0200
From: Mads Martin Joergensen <mmj@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Sleeping function called from illegal context at page_alloc.c:325
Message-ID: <20020930154614.GB20031@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey together,

The following trace was spamming my logs heavily when booting vanilla
2.5.39

http://panther.mmj.dk/lspci.txt for lspci -vvv output
http://panther.mmj.dk/config-2.5.39 for the config used.


Sep 28 19:20:50 tiger kernel: Sleeping function called from illegal context at p
age_alloc.c:325
Sep 28 19:20:50 tiger kernel: d7e03eac c0138d65 c0325cd0 00000145 d9e1f080 c0115
ec4 d7e03ee8 d9e1f480 
Sep 28 19:20:50 tiger kernel:        000001d0 d7e00040 00000000 d829b740 d7e03f4
8 d84f24a4 c0138d8f 00000000 
Sep 28 19:20:50 tiger kernel:        c0155c51 c1576bc0 d84f2400 00000000 d7e03f4
8 c0292b2f d829b740 d84f24a4 
Sep 28 19:20:50 tiger kernel: Call Trace:
Sep 28 19:20:50 tiger kernel:  [<c0138d65>]__alloc_pages+0x215/0x220
Sep 28 19:20:50 tiger kernel:  [<c0115ec4>]schedule+0x194/0x310
Sep 28 19:20:50 tiger kernel:  [<c0138d8f>]__get_free_pages+0x1f/0x60
Sep 28 19:20:50 tiger kernel:  [<c0155c51>]__pollwait+0x41/0xd0
Sep 28 19:20:50 tiger kernel:  [<c0292b2f>]snd_pcm_oss_poll+0x4f/0x120
Sep 28 19:20:50 tiger kernel:  [<c0155fe3>]do_select+0x223/0x240
Sep 28 19:20:50 tiger kernel:  [<c015636e>]sys_select+0x33e/0x4d0
Sep 28 19:20:50 tiger kernel:  [<c01077db>]syscall_call+0x7/0xb
Sep 28 19:20:50 tiger kernel: 

-- 
Mads Martin Jørgensen, http://mmj.dk
"Why make things difficult, when it is possible to make them cryptic
 and totally illogic, with just a little bit more effort?"
                                -- A. P. J.
