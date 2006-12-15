Return-Path: <linux-kernel-owner+w=401wt.eu-S932311AbWLOBEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWLOBEW (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWLOBEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:04:22 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:46514 "EHLO
	pd5mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932311AbWLOBEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:04:21 -0500
Date: Thu, 14 Dec 2006 19:03:18 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Linux 2.6.20-rc1
In-reply-to: <fa.p3mZcZJUV5vbz5aYUBbt4rJjr2A@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jens Axboe <jens.axboe@oracle.com>
Message-id: <4581F456.5040708@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.RIN4HRPnLGt7UFAh8INm8D0Re5k@ifi.uio.no>
 <fa.bn+19zl5p6JLw04wsJAH4QbLSps@ifi.uio.no>
 <fa.hRBfOTtQdNUe6Lr4YfYDijpzP5g@ifi.uio.no>
 <fa.p3mZcZJUV5vbz5aYUBbt4rJjr2A@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> I bisected all the way down to 0e75f9063f5c55fb0b0b546a7c356f8ec186825e, which 
> git reckons is the culprit. I wasn't able to revert this commit to test, 
> because it has conflicts.
> 
> Any ideas?

That would be this one I assume?

[PATCH] block: support larger block pc requests

author	Mike Christie <michaelc@cs.wisc.edu>
	Fri, 1 Dec 2006 09:40:55 +0000 (10:40 +0100)
committer	Jens Axboe <jens.axboe@oracle.com>
	Fri, 1 Dec 2006 09:40:55 +0000 (10:40 +0100)
commit	0e75f9063f5c55fb0b0b546a7c356f8ec186825e
tree	db138f641175403546c2147def4b405f3ff453a8
parent	ad2d7225709b11da47e092634cbdf0591829ae9c
[PATCH] block: support larger block pc requests

This patch modifies blk_rq_map/unmap_user() and the cdrom and scsi_ioctl.c
users so that it supports requests larger than bio by chaining them 
together.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

