Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVLAN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVLAN3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbVLAN3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 08:29:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46210 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932225AbVLAN3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 08:29:31 -0500
Subject: Re: [PATCH 0/4] linux-2.6-block: deactivating pagecache for
	benchmarks
From: Arjan van de Ven <arjan@infradead.org>
To: Dirk Henning Gerdes <mail@dirk-gerdes.de>
Cc: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1133443051.6110.32.camel@noti>
References: <1133443051.6110.32.camel@noti>
Content-Type: text/plain
Date: Thu, 01 Dec 2005 14:29:25 +0100
Message-Id: <1133443765.2853.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-01 at 14:17 +0100, Dirk Henning Gerdes wrote:
> Hi Jens!
> 
> For doing benchmarks on the I/O-Schedulers, I thought it would be very
> useful to disable the pagecache.


for benchmarks this is not enough though, you also need to clean the
inode and dentry caches, as well as any filesystem specific caches
(might be buffer cache)..... 
at which point it's probably nicer to just fake a limited umount since
that has to do all of that anyway

