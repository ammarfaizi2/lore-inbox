Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbTL3L7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265765AbTL3L7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:59:37 -0500
Received: from intra.cyclades.com ([64.186.161.6]:38339 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265764AbTL3L7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:59:36 -0500
Date: Tue, 30 Dec 2003 09:58:19 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4] Is a negative rsect in /proc/partitions normal?
In-Reply-To: <20031230024331.GN1882@matchmail.com>
Message-ID: <Pine.LNX.4.58L.0312300958050.22101@logos.cnet>
References: <20031230014429.GL1882@matchmail.com> <20031229191106.I6209@schatzie.adilger.int>
 <20031230024331.GN1882@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> struct hd_struct in include/linux/genhd.h:61 has them all unsigned int.
>
> How's this patch look against 2.4.23?
>
> --- drivers/block/genhd.c.orig	2003-12-29 18:35:35.000000000 -0800
> +++ drivers/block/genhd.c	2003-12-29 18:40:11.000000000 -0800
> @@ -201,7 +201,7 @@
>
>  			disk_round_stats(hd);
>  			seq_printf(s, "%4d  %4d %10d %s "
> -				      "%d %d %d %d %d %d %d %d %d %d %d\n",
> +				      "%u %u %u %u %u %u %u %u %u %u %u\n",
>  				      gp->major, n, gp->sizes[n],
>  				      disk_name(gp, n, buf),
>  				      hd->rd_ios, hd->rd_merges,

Looks good, applied.
