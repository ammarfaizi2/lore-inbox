Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWC3AqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWC3AqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWC3AqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:46:11 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:640 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751313AbWC3AqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:46:09 -0500
Message-ID: <442B2A4D.4010606@pobox.com>
Date: Wed, 29 Mar 2006 19:46:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       sander@humilis.net
Subject: Re: [PATCH 2.6.16] sata_mv.c :: three bug fixes
References: <200603290950.32219.lkml@rtr.ca>
In-Reply-To: <200603290950.32219.lkml@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -3.6 (---)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-3.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>  	u8 ata_status = 0;
[...]
>  	for (port = port0; port < port0 + MV_PORTS_PER_HC; port++) {
> -		ap = host_set->ports[port];
> +		struct ata_port *ap = host_set->ports[port];
> +		struct mv_port_priv *pp = ap->private_data;
>  		hard_port = port & MV_PORT_MASK;	/* range 0-3 */


Applied, even though it should be quite obvious that the patch does not 
apply to 2.6.16 at all; its missing your previous ata_status patch, 
which the upstream kernel has already included.

	Jeff


