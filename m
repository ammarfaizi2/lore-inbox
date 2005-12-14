Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVLNQ7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVLNQ7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVLNQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:59:04 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26063 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932400AbVLNQ7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:59:02 -0500
Date: Wed, 14 Dec 2005 16:59:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-scsi@vger.kernel.org
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
Message-ID: <20051214165900.GA26580@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Peschke <mp3@de.ibm.com>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, linux-scsi@vger.kernel.org
References: <43A044E6.7060403@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A044E6.7060403@de.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	atomic_t		read_num;
> +	atomic_t		write_num;
> +	struct statistic_interface	*stat_if;
> +	struct statistic		*stat_sizes_scsi_write;
> +	struct statistic		*stat_sizes_scsi_read;
> +	struct statistic		*stat_sizes_scsi_nodata;
> +	struct statistic		*stat_sizes_scsi_nofit;
> +	struct statistic		*stat_sizes_scsi_nomem;
> +	struct statistic		*stat_sizes_timedout_write;
> +	struct statistic		*stat_sizes_timedout_read;
> +	struct statistic		*stat_sizes_timedout_nodata;
> +	struct statistic		*stat_latencies_scsi_write;
> +	struct statistic		*stat_latencies_scsi_read;
> +	struct statistic		*stat_latencies_scsi_nodata;
> +	struct statistic		*stat_pending_scsi_write;
> +	struct statistic		*stat_pending_scsi_read;
> +	struct statistic		*stat_erp;
> +	struct statistic		*stat_eh_reset;

NACK.  pretty much all of this is generic and doesn't belong into an LLDD.
We already had this statistics things with emulex and they added various
bits to the core in response.

