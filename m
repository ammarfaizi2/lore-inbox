Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUGJUSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUGJUSy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 16:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266409AbUGJUSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 16:18:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:56001 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266391AbUGJUSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 16:18:47 -0400
Date: Sat, 10 Jul 2004 13:17:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <edt@aei.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops 2.6.7-mm7
Message-Id: <20040710131732.4516dee6.akpm@osdl.org>
In-Reply-To: <200407100843.49441.edt@aei.ca>
References: <200407100843.49441.edt@aei.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <edt@aei.ca> wrote:
>
> During startup of mm7 with ingo's H3 preemption patch added I get the following oops:
> 
>  Jul 10 08:05:48 bert kernel: Modules linked in: snd_es18xx snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_o
>  pl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore nfs lockd sunrpc md dm_mod p
>  cspkr e100 mii autofs4 af_packet ext3 jbd nls_iso8859_1 nls_cp437 apm rtc
>  Jul 10 08:05:48 bert kernel: CPU:    0
>  Jul 10 08:05:48 bert kernel: EIP:    0060:[dma_alloc_coherent+28/256]    Not tainted VLI

You're not the only person to see this.  Reverting
bk-dma-declare-coherent-memory.patch should fix it.
