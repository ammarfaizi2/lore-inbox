Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTDXIfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTDXIfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:35:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45704 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261832AbTDXIfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:35:22 -0400
Date: Thu, 24 Apr 2003 10:47:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as-iosched:1210
Message-ID: <20030424084717.GF8775@suse.de>
References: <Pine.LNX.4.50.0304222259300.2085-100000@montezuma.mastecende.com> <3EA7A0CC.50005@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA7A0CC.50005@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24 2003, Nick Piggin wrote:
> Zwane Mwaikambo wrote:
> 
> >I'm not sure wether you want this, it was during error handling from the 
> >HBA driver (source was disk error).
> >
> >scsi1: ERROR on channel 0, id 3, lun 0, CDB: Read (10) 00 00 7f de 60 00 
> >00 80 00 Info fld=0x7fdeb2, Current sdd: sense key Medium Error
> >Additional sense: Unrecovered read error
> >end_request: I/O error, dev sdd, sector 8380032
> >Badness in as_add_request at drivers/block/as-iosched.c:1210
> >
> Thanks I'll have a look.

The debug check looks broken, request could have come from somewhere
else than the block pool.

-- 
Jens Axboe

