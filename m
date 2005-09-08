Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932688AbVIHPSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932688AbVIHPSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932690AbVIHPSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:18:01 -0400
Received: from pat.qlogic.com ([198.70.193.2]:10951 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S932688AbVIHPSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:18:00 -0400
Date: Thu, 8 Sep 2005 08:17:55 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] Warning in the qla2xxx driver
Message-ID: <20050908151755.GD6357@plap.qlogic.org>
References: <1125603506.4867.23.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125603506.4867.23.camel@dhcp153.mvista.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 08 Sep 2005 15:17:55.0738 (UTC) FILETIME=[7D1AAFA0:01C5B488]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Sep 2005, Daniel Walker wrote:

> Remove possible uninitialized "sg" field warning in the qla24xx driver
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 
> Index: linux-2.6.13/drivers/scsi/qla2xxx/qla_iocb.c
> ===================================================================
> --- linux-2.6.13.orig/drivers/scsi/qla2xxx/qla_iocb.c	2005-08-28 23:41:01.000000000 +0000
> +++ linux-2.6.13/drivers/scsi/qla2xxx/qla_iocb.c	2005-08-31 18:31:03.000000000 +0000
> @@ -744,7 +744,7 @@ qla24xx_start_scsi(srb_t *sp)
>  	uint32_t        index;
>  	uint32_t	handle;
>  	struct cmd_type_7 *cmd_pkt;
> -	struct scatterlist *sg;
> +	struct scatterlist *sg = NULL;
>  	uint16_t	cnt;
>  	uint16_t	req_cnt;
>  	uint16_t	tot_dsds;

This was already addressed in the following patch:

http://marc.theaimsgroup.com/?l=linux-scsi&m=112510857722632&w=2

which was recently pull by Linus:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=131736d34ebc3251d79ddfd08a5e57a3e86decd4

--
av
