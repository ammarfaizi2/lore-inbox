Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRBYObj>; Sun, 25 Feb 2001 09:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129304AbRBYOba>; Sun, 25 Feb 2001 09:31:30 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64774 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129299AbRBYObY>; Sun, 25 Feb 2001 09:31:24 -0500
Subject: Re: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
To: rasmus@jaquet.dk (Rasmus Andersen)
Date: Sun, 25 Feb 2001 14:34:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010225151930.C764@jaquet.dk> from "Rasmus Andersen" at Feb 25, 2001 03:19:30 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X2Fq-0003Ai-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looking at the define of NCR_5380_write
> 
> #define NCR5380_write(reg, value) isa_writeb(NCR5380_map_name + +NCR53C400_mem_base + (reg), value)
> 
> followed by an use of NCR5380_write
> 
>     NCR5380_write(C400_CONTROL_STATUS_REG, CSR_BASE | CSR_TRANS_DIR);
> 
> I doubt that it is not the intention to write CSR_BASE | CSR_TRANS_DIR
> at the offset C400_CONTROL_STATUS_REG. But note that this argument
> swap only is in the code produced by -DCONFIG_SCSI_G_NCR5380_MEM.
> Perhaps you use CONFIG_SCSI_G_NCR5380_PORT? Otherwise I must admit
> that I have been had...

Im running PIO. However while I agree with that one Im dubious about the
inverts on the memcpy_*io bits

Alan

