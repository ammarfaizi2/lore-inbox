Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVAJPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVAJPxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 10:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVAJPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 10:51:43 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:2001 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262304AbVAJPvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 10:51:24 -0500
Subject: RE: [PATCH 2.6] cciss typo fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DC0188@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF107DC0188@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 09:50:38 -0600
Message-Id: <1105372238.4477.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 09:45 -0600, Miller, Mike (OS Dev) wrote:
> Even if it were added to the compat header; is using __be32 correct in this context?

They should be.  The __be annotations track unconverted big endian
numbers.  be32_to_cpu checks that it's only taking __be annotated
variables (at least when sparse tracks it), so the cast is correct and
prevents sparse from warning.

James


