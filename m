Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264871AbUEQAdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbUEQAdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 20:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUEQAdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 20:33:49 -0400
Received: from cicero2.cybercity.dk ([212.242.40.53]:26380 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id S264871AbUEQAdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 20:33:45 -0400
Subject: Re: Kernel OOPS
From: tmp <skrald@amossen.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040516162716.34f3d94a.akpm@osdl.org>
References: <1084709330.743.8.camel@debian>
	 <20040516162716.34f3d94a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1084754022.2509.2.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 02:33:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, for your reply!

> It's a bit strange that no registers have a value vaguely like
> 0x1841b518, but at a guess I'd say that you have a bad ->owner
> pointer in a /proc inode.

> What modules are you using

$ lsmod
Module                  Size  Used by
apm                    15536  1
md5                     3648  1
ipv6                  220064  19
snd_ice1712            41928  0
snd_ice17xx_ak4xxx      3136  1 snd_ice1712
snd_pcm_oss            48420  0
snd_mixer_oss          17216  1 snd_pcm_oss
snd_pcm                81636  2 snd_ice1712,snd_pcm_oss
snd_page_alloc          8964  1 snd_pcm
snd_timer              19844  1 snd_pcm
snd_ak4xxx_adda         5376  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_cs8427              8768  1 snd_ice1712
snd_ac97_codec         60868  1 snd_ice1712
snd_i2c                 4800  2 snd_ice1712,snd_cs8427
snd_mpu401_uart         5824  1 snd_ice1712
snd_rawmidi            18976  1 snd_mpu401_uart
ide_scsi               13764  0
scsi_mod               61500  1 ide_scsi
parport_pc             18528  1
lp                      7940  0
parport                20608  2 parport_pc,lp
nls_cp437               5376  2
rtc                     9464  0
unix                   21552  612


> , and had any modules been rmmod'ed prior
> to the crash?

No.

By the way, I can tell, that I recently got the following message
printed on a shell I opened, just before it crashed (handwritten from
screen (keyboard was locked)):

Assertion failure in __journal_file_buffer() at
fs/jbd/transaction.c:1934: "jh->b_transaction == transaction ||
jh->b_transaction == 0"



