Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWJRJlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWJRJlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 05:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWJRJlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 05:41:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18061 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750980AbWJRJlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 05:41:05 -0400
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
From: Arjan van de Ven <arjan@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061018080030.GU23492@unthought.net>
References: <CAEAF2308EEED149B26C2C164DFB20F4E7EAFE@ALPMLVEM06.e2k.ad.ge.com>
	 <1161048269.3245.26.camel@laptopd505.fenrus.org>
	 <20061017132312.GD7854@kernel.dk>  <20061018080030.GU23492@unthought.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 18 Oct 2006 11:40:56 +0200
Message-Id: <1161164456.3128.81.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 10:00 +0200, Jakob Oestergaard wrote:
> On Tue, Oct 17, 2006 at 03:23:13PM +0200, Jens Axboe wrote:
> > On Tue, Oct 17 2006, Arjan van de Ven wrote:
> ...
> > > Hi,
> > > 
> > > it's a nice idea in theory. However... since IO bandwidth for seeks is
> > > about 1% to 3% of that of sequential IO (on disks at least), which
> > > bandwidth do you want to allocate? "worst case" you need to use the
> > > all-seeks bandwidth, but that's so far away from "best case" that it may
> > > well not be relevant in practice. Yet there are real world cases where
> > > for a period of time you approach worst case behavior ;(
> > 
> > Bandwidth reservation would have to be confined to special cases, you
> > obviously cannot do it "in general" for the reasons Arjan lists above.
> 
> How about allocating I/O operations instead of bandwidth ?
> 
> So, any read is really a seek+read, and we count that as one I/O
> operation. Same for writes.

Hi,

I can see that that makes it simple, but.. what would it MEAN? Eg what
would a system administrator use it for? It then no longer means "my mp3
player is guaranteed to get the streaming mp3 from the disk at this
bitrate" or something like that... so my question to you is: can you
describe what it'd bring the admin to put such an allocation in place?
If we find that it can be a good approach.. but if not, I'm less certain
this'll be used..

Greetings,
   Arjan van de Ven

