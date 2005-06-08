Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVFHTjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVFHTjr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVFHThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:37:04 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:25790 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261573AbVFHTgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:36:43 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] SATA NCQ #4
Date: Thu, 09 Jun 2005 05:36:28 +1000
Organization: <http://scatter.mine.nu/>
Message-ID: <tbgea15ls0a5kovgnsr62fkhtgnspmjfeg@4ax.com>
References: <20050608102857.GC18490@suse.de> <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com> <20050608114150.GE18490@suse.de> <20050608114526.GF18490@suse.de>
In-Reply-To: <20050608114526.GF18490@suse.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005 13:45:26 +0200, Jens Axboe <axboe@suse.de> wrote:
>
>Any chance you can log the boot process when it fails, using serial
>console or something similar? At least write down the EIP of where it
>fails :-)

Guess what?  I switched box on this morning with monitor off and 
the boot completed, 'cos I'd logged in much time later ssh.  Didn't 
give it enough time yesterday :(

I have one very large syslog... 139MB

How much of that would you like :)

Jun  9 04:27:45 sempro kernel:  [<c0100ad3>] default_idle+0x23/0x30
Jun  9 04:27:45 sempro kernel:  [<c0100b58>] cpu_idle+0x48/0x60
Jun  9 04:27:45 sempro kernel:  [<c04867b8>] start_kernel+0x148/0x170
Jun  9 04:27:45 sempro kernel:  [<c04863a0>] unknown_bootoption+0x0/0x1b0
Jun  9 04:27:45 sempro kernel: Badness in __ata_qc_complete at drivers/scsi/libata-core.c:3062
Jun  9 04:27:45 sempro kernel:  [<c02ae908>] __ata_qc_complete+0x38/0x120
Jun  9 04:27:45 sempro kernel:  [<c02b0d9b>] ata_scsi_qc_complete+0x2b/0x50
Jun  9 04:27:45 sempro kernel:  [<c02aeac6>] ata_qc_complete+0x46/0xc0
Jun  9 04:27:45 sempro kernel:  [<c02af13d>] ata_interrupt+0xcd/0x110
Jun  9 04:27:45 sempro kernel:  [<c01308e0>] handle_IRQ_event+0x30/0x70
Jun  9 04:27:45 sempro kernel:  [<c01309c2>] __do_IRQ+0xa2/0xe0
Jun  9 04:27:45 sempro kernel:  [<c0105059>] do_IRQ+0x19/0x30
Jun  9 04:27:45 sempro kernel:  [<c0103492>] common_interrupt+0x1a/0x20
Jun  9 04:27:45 sempro kernel:  [<c0100ab0>] default_idle+0x0/0x30
Jun  9 04:27:45 sempro kernel:  [<c0100ad3>] default_idle+0x23/0x30
Jun  9 04:27:45 sempro kernel:  [<c0100b58>] cpu_idle+0x48/0x60
Jun  9 04:27:45 sempro kernel:  [<c04867b8>] start_kernel+0x148/0x170
Jun  9 04:27:45 sempro kernel:  [<c04863a0>] unknown_bootoption+0x0/0x1b0
Jun  9 04:27:45 sempro kernel: Badness in __ata_qc_complete at drivers/scsi/libata-core.c:3062

--Grant.

