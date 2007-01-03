Return-Path: <linux-kernel-owner+w=401wt.eu-S932163AbXACXHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXACXHK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 18:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbXACXHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 18:07:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58839 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932163AbXACXHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 18:07:08 -0500
Date: Wed, 3 Jan 2007 15:06:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Philip Langdale <philipl@overt.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, linux-kernel@vger.kernel.org,
       John Gilmore <gnu@toad.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
Message-Id: <20070103150620.ac733abb.akpm@osdl.org>
In-Reply-To: <459928F3.9010804@overt.org>
References: <459928F3.9010804@overt.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Jan 2007 07:29:55 -0800
Philip Langdale <philipl@overt.org> wrote:

>  #define MMC_RSP_R1B	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
>  #define MMC_RSP_R2	(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
>  #define MMC_RSP_R3	(MMC_RSP_PRESENT)
> -#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC)
> +#define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
> +#define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)

This gives MMC_RSP_R1 and MMC_RSP_R6 the same value, so

drivers/mmc/tifm_sd.c: In function 'tifm_sd_op_flags':
drivers/mmc/tifm_sd.c:190: error: duplicate case value
drivers/mmc/tifm_sd.c:181: error: previously used here
