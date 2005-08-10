Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbVHJVYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbVHJVYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 17:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVHJVYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 17:24:18 -0400
Received: from mail.dvmed.net ([216.237.124.58]:34721 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030275AbVHJVYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 17:24:17 -0400
Message-ID: <42FA7076.6060801@pobox.com>
Date: Wed, 10 Aug 2005 17:24:06 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] sata: fix sata_sx4 dma_prep to not use sg->length
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <20050807055340.GB13335@htj.dyndns.org>
In-Reply-To: <20050807055340.GB13335@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
>  sata_sx4 directly references sg->length to calculate total_len in
> pdc20621_dma_prep().  This is incorrect as dma_map_sg() could have
> merged multiple sg's into one and, in such case, sg->length doesn't
> reflect true size of the entry.  This patch makes it use
> sg_dma_len(sg).
> 
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

applied to 2.6.13


