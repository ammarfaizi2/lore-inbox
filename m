Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbUCLPwC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 10:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUCLPwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 10:52:01 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:55570 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262328AbUCLPvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 10:51:48 -0500
Date: Fri, 12 Mar 2004 15:51:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Chris Mason <mason@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfs patch for 2.6
Message-ID: <20040312155145.A16751@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
References: <1078867885.25075.1458.camel@watt.suse.com> <20040312093146.A13678@infradead.org> <1079106653.4185.171.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1079106653.4185.171.camel@watt.suse.com>; from mason@suse.com on Fri, Mar 12, 2004 at 10:50:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 10:50:53AM -0500, Chris Mason wrote:
> Would you like this better:
> 
> device mapper code:
> 	fsync_bdev(bdev);
> 	s = freeze_fs(bdev);
> 	< create snap shot >
> 	thaw_fs(bdev, s);

Hmm, I actually thought about moving the fsync_bdev into
freeze_fs, but having it separate might more sense indeed.

> thaw_fs needs the bdev so it can up the bdev mount semaphore.

sb->s_bdev should do it aswell

