Return-Path: <linux-kernel-owner+w=401wt.eu-S1751878AbXAVPBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXAVPBc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 10:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbXAVPBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 10:01:32 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:47655 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751878AbXAVPBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 10:01:31 -0500
Subject: Re: [RFC 3/6] bidi support: bidirectional request
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Christoph Hellwig <hch@infradead.org>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com,
       Daniel.E.Messinger@seagate.com, Liran Schour <LIRANS@il.ibm.com>,
       Benny Halevy <bhalevy@panasas.com>
In-Reply-To: <45B3F64C.3030805@panasas.com>
References: <45B3F64C.3030805@panasas.com>
Content-Type: text/plain
Date: Mon, 22 Jan 2007 09:00:21 -0600
Message-Id: <1169478021.2769.5.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-22 at 01:25 +0200, Boaz Harrosh wrote:
> - Instantiate another request_io_part in request for bidi_read.
> - Define & Implement new API for accessing bidi parts.
> - API to Build bidi requests and map to sglists.
> - Define new end_that_request_block() function to end a complete request.

Actually, this approach looks to be a bit too narrow.  You seem to be
predicating on the idea that the bidirectional will transfer in and out
of the same area.  For some of the frame in/frame out stuff, we probably
need the read and write areas for the bidirectional request to be
separated.

James


