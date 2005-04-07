Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262470AbVDGNcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVDGNcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVDGNcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:32:05 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:57765 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262467AbVDGNbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:31:08 -0400
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@suse.de>, Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050407132205.GA16517@infradead.org>
References: <20050329115405.97559.qmail@web52909.mail.yahoo.com>
	 <20050329120311.GO16636@suse.de> <1112804840.5476.16.camel@mulgrave>
	 <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave>
	 <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave>
	 <20050407064934.GJ15165@suse.de> <1112879919.5842.3.camel@mulgrave>
	 <20050407132205.GA16517@infradead.org>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:30:58 -0400
Message-Id: <1112880658.5842.10.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 14:22 +0100, Christoph Hellwig wrote:
> Do we really need the sdev_lock pointer?  There's just a single place
> where we're using it and the code would be much more clear if it had just
> one name.

Humour me for a while.  I don't believe we have any way the lock can be
used after calling queue free, but nulling the sdev_lock pointer will
surely catch them.  If nothing turns up after a few kernel revisions,
feel free to kill it.

James


