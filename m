Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTKJOSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262901AbTKJOSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:18:04 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:63387 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262878AbTKJOSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:18:02 -0500
Subject: Re: SFFDC and blksize_size
From: David Woodhouse <dwmw2@infradead.org>
To: Jens Axboe <axboe@suse.de>
Cc: Simon Haynes <simon@baydel.com>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20031110140927.GE32637@suse.de>
References: <37CC93E8710D@baydel.com>  <20031110140927.GE32637@suse.de>
Content-Type: text/plain
Message-Id: <1068473878.5743.6.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Mon, 10 Nov 2003 14:17:59 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-10 at 15:09 +0100, Jens Axboe wrote:
> On Fri, Nov 07 2003, Simon Haynes wrote:
> > 
> > I have been writing a block driver for SSFDC compliant SMC cards. This stuff 
> > allocates 16k blocks.  When I get requests the transfers are split into the 
> > size I specifty in the blksize_size{MAJOR] array. It sems that most things 
> 
> Sounds like a bad way to do it. It's much better to prevent builds of
> bigger requests than you can handle in one go. You don't mention what
> kernel you are using, but both 2.4 and 2.6 can do this for you.

The problem is the other way round -- he wants request merging, and he's
achieving this by setting the block size higher.... and observing a
crash when he sets his block size higher than PAGE_SIZE.


-- 
dwmw2

