Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbTEFKbu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbTEFKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:31:50 -0400
Received: from [66.212.224.118] ([66.212.224.118]:51980 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S262513AbTEFKbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:31:49 -0400
Date: Tue, 6 May 2003 06:35:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Tommy Wu <tommy@teatime.com.tw>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69, aar_rx_intr, irq 30: nobody cared! 
In-Reply-To: <20030506173007.FDEC.TOMMY@teatime.com.tw>
Message-ID: <Pine.LNX.4.50.0305060608530.13957-100000@montezuma.mastecende.com>
References: <20030506173007.FDEC.TOMMY@teatime.com.tw>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Tommy Wu wrote:

> May  6 13:15:37 test kernel: handlers:
> May  6 13:15:37 test kernel: [aac_rx_intr+0/212]
> May  6 13:15:37 test kernel: irq 30: nobody cared!
> May  6 13:15:37 test kernel: Call Trace: [handle_IRQ_event+147/232]  [do_IRQ+194/304]
>   [  common_interrupt+24/32]  [try_to_unmap_one+275/368]  [bio_put+24/48]  
>   [end_bio_bh_io_sync+33/48]  [bio_endio+70/76]  [__end_that_request_first+256/464] 
>   [end_that_request_first+23/28]  [scsi_end_request+36/160]  [scsi_io_completion+561/1100]
>   [sd_rw_intr+470/480]  [scsi_finish_command+208/216]  [scsi_softirq+490/516]  
>   [do_softirq+106/200]  [do_IRQ+288/304]  [default_idle+0/52]  [rest_init+0/72]  
>   [common_interrupt+24/32]  [default_idle+0/52]  [rest_init+0/72]  [default_idle+41/52]  
>   [cpu_idle+55/72]  [rest_init+69/72]  [start_kernel+379/384]

How spurious are these? I just looked at the OIMR programming and i can't 
see how this managed to slip by, perhaps someone really doesn't honour 
their interrupt disable bit.

-- 
function.linuxpower.ca
