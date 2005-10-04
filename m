Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbVJDVOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbVJDVOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 17:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVJDVOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 17:14:19 -0400
Received: from keskus.netlab.hut.fi ([130.233.154.176]:21956 "EHLO
	keskus.netlab.hut.fi") by vger.kernel.org with ESMTP
	id S964973AbVJDVOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 17:14:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17218.61609.178742.824607@keskus.netlab.hut.fi>
Date: Wed, 5 Oct 2005 00:14:17 +0300
From: Jouni Karvo <jouni.karvo@tkk.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] mtrr's not set, 2.6.13
X-Mailer: VM 7.19 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

I have the same problem of MTRR:s and kernel 2.6.13.2

With 2.6.9, the system says:

kex@vdr:~$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1

but with 2.6.13.2:

kex@vdr:/var/log$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1

Processor type: (I added the mask printouts to void __init
mtrr_bp_init(void) in mtrr/main.c)

eck reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
MTRR: size_or_mask = 0xf0000000, size_and_mask = 0xff00000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 03

Please let me know what info would help tracking this down...

yours,
		Jouni

Btw. sorry I did not have the references for the earlier postings.
-- 
http://www.tkk.fi/%7ekex
