Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbUJXP7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUJXP7H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbUJXP5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:57:13 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:13736 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261543AbUJXPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:54:34 -0400
Subject: Re: [patch 1/2] cciss: cleans up warnings in the 32/64 bit
	conversions
From: James Bottomley <James.Bottomley@SteelEye.com>
To: mikem@beardog.cca.cpqcorp.net
Cc: marcelo.tosatti@cyclades.com, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
References: <20041021211718.GA10462@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2004 11:54:15 -0400
Message-Id: <1098633262.10824.35.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-21 at 17:17, mike.miller@hp.com wrote:
> Patch 1 of 2 for 20041021.
> This patch cleans up some warnings in the 32-bit to 64-bit conversions.
> Please consider this for inclusion. Built against 2.4.28-pre4.
> Please apply in order.

There's something wrong with this patch (it might be a missing prior
patch) that's causing it to reject comprehensively.

> -typedef long (*handler_type) (unsigned int, unsigned int, unsigned long,
> +typedef int (*handler_type) (unsigned int, unsigned int, unsigned long,

Things like this.  handler_type has always been int not long in the
source that's currently in the tree.

James


