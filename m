Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUKFQsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUKFQsy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 11:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261420AbUKFQsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 11:48:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42406 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261418AbUKFQsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 11:48:52 -0500
Message-ID: <418D0066.9040002@pobox.com>
Date: Sat, 06 Nov 2004 11:48:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] WIN_* -> ATA_CMD_* conversion: add new entries to
 ata.h
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com> <20041106032305.GB6060@taniwha.stupidest.org>
In-Reply-To: <20041106032305.GB6060@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> ===== include/linux/ata.h 1.19 vs edited =====
> --- 1.19/include/linux/ata.h	2004-11-02 11:32:44 -08:00
> +++ edited/include/linux/ata.h	2004-11-05 19:04:41 -08:00
> @@ -122,6 +122,27 @@
>  	ATA_CMD_SET_FEATURES	= 0xEF,
>  	ATA_CMD_PACKET		= 0xA0,
>  
> +	/* ATA devices commands (used by legacy IDE code) */
> +	ATA_CMD_NOP		= 0x00,
> +	ATA_CMD_SRST		= 0x08,
> +	ATA_CMD_RESTORE		= 0x10,
> +	ATA_CMD_MULTREAD_EXT	= 0x29,
> +	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
> +	ATA_CMD_MULTWRITE_EXT	= 0x39,
> +	ATA_CMD_SPECIFY		= 0x91, /* set geom */
> +	ATA_CMD_SMART		= 0xB0,
> +	ATA_CMD_MULTREAD	= 0xC4,
> +	ATA_CMD_MULTWRITE	= 0xC5,
> +	ATA_CMD_MULTSET		= 0xC6,
> +	ATA_CMD_DOORLOCK	= 0xDE,
> +	ATA_CMD_DOORUNLOCK	= 0xDF,
> +	ATA_CMD_STANDBYNOW1	= 0xE0,
> +	ATA_CMD_IDLEIMMEDIATE	= 0xE1,
> +	ATA_CMD_ID_ATA_DMA	= 0xEE,
> +	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
> +	ATA_CMD_SET_MAX		= 0xF9,
> +	ATA_CMD_SET_MAX_EXT	= 0x37,

No need for a separate "section" for ATA_CMD_xxx used by libata versus 
IDE driver.  ATA_CMD_xxx are just constants, available for any user. 
There is no discernible order in current linux/ata.h, so feel free to 
alphabetize or order by opcode (or just leave as-is).

	Jeff



