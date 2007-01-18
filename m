Return-Path: <linux-kernel-owner+w=401wt.eu-S932147AbXARKcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXARKcr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 05:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbXARKcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 05:32:47 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:45036 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147AbXARKcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 05:32:46 -0500
Date: Thu, 18 Jan 2007 11:31:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <jens.axboe@oracle.com>
cc: linux-kernel@vger.kernel.org, KudOS <kudos@lists.ucla.edu>
Subject: Re: block_device usage and incorrect block writes
In-Reply-To: <20070118021306.GA22842@kernel.dk>
Message-ID: <Pine.LNX.4.61.0701181131070.19740@yvahk01.tjqt.qr>
References: <20070118010851.GA28129@pooh.cs.ucla.edu> <20070118021306.GA22842@kernel.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Jan 18 2007 13:13, Jens Axboe wrote:
>
>noop doesn't guarentee that IO will be queued with the device in the
>order in which they are submitted, and it definitely doesn't guarentee
>that the device will process them in the order in which they are
>dispatched. noop being FIFO basically means that it will not sort
>requests. You can still have reordering if one request gets merged with
>another, for instance.

Would it make sense to have a fifo-iosched module that assumes write barriers
between every submission? (No, I am not related to that project.)


	-`J'
-- 
