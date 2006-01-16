Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWAPT5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWAPT5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWAPT5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:57:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:7402 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750829AbWAPT5y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:57:54 -0500
Subject: Re: [PATCH] Fall back io scheduler ( Re: [Ext2-devel] Re: Fall
	back io scheduler for 2.6.15?)
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20060116194907.GO3945@suse.de>
References: <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
	 <20060110212551.411a766d.akpm@osdl.org>
	 <1137007032.4395.24.camel@localhost.localdomain>
	 <20060111114303.45540193.akpm@osdl.org>
	 <1137201135.4353.81.camel@localhost.localdomain>
	 <20060113174914.7907bf2c.akpm@osdl.org> <20060116084309.GN3945@suse.de>
	 <1137440735.3724.17.camel@dyn9047017067.beaverton.ibm.com>
	 <20060116194907.GO3945@suse.de>
Content-Type: text/plain
Organization: IBM LTC
Date: Mon, 16 Jan 2006 11:57:43 -0800
Message-Id: <1137441463.3724.19.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 20:49 +0100, Jens Axboe wrote:
> On Mon, Jan 16 2006, Mingming Cao wrote:
> > On Mon, 2006-01-16 at 09:43 +0100, Jens Axboe wrote:
> > > On Fri, Jan 13 2006, Andrew Morton wrote:
> > > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > > >
> > > > > On 2.6.14, the
> > > > > fall back io scheduler (if the chosen io scheduler is not found) is set
> > > > > to the default io scheduler (anticipatory, in this case), but since
> > > > > 2.6.15-rc1, this semanistic is changed to fall back to noop.
> > > > 
> > > > OK.  And I assume that AS wasn't compiled, so that's why it fell back?
> > > > 
> > > > I actually thought that elevator= got removed, now we have
> > > > /sys/block/sda/queue/scheduler.  But I guess that's not very useful with
> > > > CONFIG_SYSFS=n.
> > > > 
> > > > > Is there any reason to fall back to noop instead of as?  It seems
> > > > > anticipatory is much better than noop for ext3 with large sequential
> > > > > write tests (i.e, 1G dd test) ...
> > > > 
> > > > I suspect that was an accident.  Jens?
> > > 
> > > It is, it makes more sense to fallback to the default of course.
> > > 
> > 
> > How about this one?
> > 
> > 
> > In the case the chosen io scheduler (elevator = "xxx") is not on the
> > registered list, fall back to default scheduler makes more sense.
> > 
> > Signed-off-by: Mingming Cao <cmm@us.ibm.com>
> 
> I think you just recreated an identical patch to the one I added this
> morning:
> 
> http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=commitdiff;h=b7bfcf7cbd58d2a64aa46f3b4bec921e346e604f
> 
> :-)
> 

Hehe, please ignore mine:-)

