Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965151AbVKBSjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbVKBSjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVKBSjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:39:12 -0500
Received: from [216.184.48.14] ([216.184.48.14]:10426 "HELO main.xsigo.com")
	by vger.kernel.org with SMTP id S965151AbVKBSjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:39:11 -0500
Date: Wed, 2 Nov 2005 10:38:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [BLOCK] Unify the seperate read/write io stat fields into arrays
Message-ID: <20051102183820.GA30291@taniwha.stupidest.org>
References: <200511021704.jA2H4X4u027306@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511021704.jA2H4X4u027306@hera.kernel.org>
X-OriginalArrivalTime: 02 Nov 2005 18:38:50.0584 (UTC) FILETIME=[AB127580:01C5DFDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wouldn't mind a comment with that:

>  struct disk_stats {
> -	unsigned read_sectors, write_sectors;
> -	unsigned reads, writes;
> -	unsigned read_merges, write_merges;
> -	unsigned read_ticks, write_ticks;
	/* Element 0 is for reads, 1 for writes */
> +	unsigned sectors[2];
> +	unsigned ios[2];
> +	unsigned merges[2];
> +	unsigned ticks[2];
>  	unsigned io_ticks;
>  	unsigned time_in_queue;
>  };
