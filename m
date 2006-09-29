Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422817AbWI2Ubq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422817AbWI2Ubq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWI2Ubq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:31:46 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:44304 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030209AbWI2Ubo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:31:44 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] list module taint flags in Oops/panic
Date: Fri, 29 Sep 2006 21:31:43 +0100
User-Agent: KMail/1.9.4
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       devzero@web.de
References: <20060928191200.5b76998c.rdunlap@xenotime.net>
In-Reply-To: <20060928191200.5b76998c.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609292131.43752.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 September 2006 03:12, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> When listing loaded modules during an oops or panic, also list each
> module's Tainted flags if non-zero (P: Proprietary or F: Forced load only).
>
> If a module is did not taint the kernel, it is just listed like
> 	usbcore
> but if it did taint the kernel, it is listed like
> 	wizmodem(PF)
>
> Example:
> [ 3260.121718] Unable to handle kernel NULL pointer dereference at
> 0000000000000000 RIP: [ 3260.121729]  [<ffffffff8804c099>]
> :dump_test:proc_dump_test+0x99/0xc8 [ 3260.121742] PGD fe8d067 PUD 264a6067
> PMD 0
> [ 3260.121748] Oops: 0002 [1] SMP
> [ 3260.121753] CPU 1
> [ 3260.121756] Modules linked in: dump_test(P) snd_pcm_oss snd_mixer_oss
> snd_seq snd_seq_device ide_cd generic ohci1394 snd_hda_intel snd_hda_codec
> snd_pcm snd_timer snd ieee1394 snd_page_alloc piix ide_core arcmsr aic79xx
> scsi_transport_spi usblp [ 3260.121785] Pid: 5556, comm: bash Tainted: P   
>   2.6.18-git10 #1
>
> [Alternatively, I can look into listing tainted flags with 'lsmod',
> but that won't help in oopsen/panics so much.]

I think this is definitely a good start.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
