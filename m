Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTE0ONX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTE0ONX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:13:23 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:44804 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262151AbTE0ONW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:13:22 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030527123901.GJ845@suse.de>
References: <1053972773.2298.177.camel@mulgrave>
	<20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave>
	<20030526190707.GM845@suse.de> <1053976644.2298.194.camel@mulgrave>
	<20030526193327.GN845@suse.de>  <20030527123901.GJ845@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 10:26:33 -0400
Message-Id: <1054045594.1769.24.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 08:39, Jens Axboe wrote:
> James, something like this would be enough then (untested, compiles)?

Yes...the only concern I would have is that if you downsize the tag map,
you don't seem to keep any memory of what the high water mark actually
is.  Thus, I can drop the depth by 8 and then increase it again by 4 and
you won't see that the increase can be accommodated by the already
allocated space.

James


