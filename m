Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264618AbTE1JWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 05:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTE1JWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 05:22:39 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:53520 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264618AbTE1JWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 05:22:38 -0400
Date: Wed, 28 May 2003 10:35:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030528103542.A27059@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com> <1054047595.1975.64.camel@mulgrave> <20030527152113.GA21744@gtf.org> <1054049931.1975.129.camel@mulgrave> <20030527155053.GB21744@gtf.org> <1054051233.1975.139.camel@mulgrave> <20030527161624.GC21744@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030527161624.GC21744@gtf.org>; from jgarzik@pobox.com on Tue, May 27, 2003 at 12:16:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 12:16:24PM -0400, Jeff Garzik wrote:
> > Well, OK, that's not an in-kernel issue.
> 
> It's definitely an in-kernel issue, because the mapping is in-kernel now:
> 
> 	<major,minor> -> queue

The mapping in the kernel is gendisk -> queue.  On the syscall
boundary we have an addition dev_t -> gendisk mapping.  The
scsi midlayer e.g. doesn't care about dev_t or even major / minor
at all.

