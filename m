Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSFTFmz>; Thu, 20 Jun 2002 01:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSFTFmy>; Thu, 20 Jun 2002 01:42:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46497 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312558AbSFTFmx>;
	Thu, 20 Jun 2002 01:42:53 -0400
Date: Thu, 20 Jun 2002 07:42:30 +0200
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Paul Bristow <paul@paulbristow.net>, Gadi Oxman <gadio@netvision.net.il>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
Message-ID: <20020620054230.GK812@suse.de>
References: <Pine.SOL.4.30.0206192338490.18992-200000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0206192338490.18992-200000@mion.elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19 2002, Bartlomiej Zolnierkiewicz wrote:

Looks pretty good in general, just one minor detail:

> +
> +/*
> + *	ATAPI packet commands.
> + */
> +#define ATAPI_FORMAT_UNIT_CMD		0x04
> +#define ATAPI_INQUIRY_CMD		0x12

[snip]

We already have the "full" list in cdrom.h (GPCMD_*), so lets just use
that. After all, ATAPI_MODE_SELECT10_CMD _is_ the same as the SCSI
variant (and I think the _CMD post fixing is silly, anyone familiar with
this is going to know what ATAPI_WRITE10 means just fine)

Same for request_sense, that is already generalized in cdrom.h as well.

-- 
Jens Axboe

