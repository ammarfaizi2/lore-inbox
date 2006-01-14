Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945971AbWANBr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945971AbWANBr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 20:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWANBr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 20:47:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36498 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945971AbWANBr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 20:47:26 -0500
Date: Fri, 13 Jan 2006 17:49:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: cmm@us.ibm.com
Cc: seelam@cs.utep.edu, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, Jens Axboe <axboe@suse.de>
Subject: Re: Fall back io scheduler for 2.6.15?
Message-Id: <20060113174914.7907bf2c.akpm@osdl.org>
In-Reply-To: <1137201135.4353.81.camel@localhost.localdomain>
References: <1112673094.14322.10.camel@mindpipe>
	<1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	<1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	<1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113244710.4413.38.camel@localhost.localdomain>
	<1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113288087.4319.49.camel@localhost.localdomain>
	<1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	<1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	<1114207837.7339.50.camel@localhost.localdomain>
	<1114659912.16933.5.camel@mindpipe>
	<1114715665.18996.29.camel@localhost.localdomain>
	<1136935562.4901.41.camel@dyn9047017067.beaverton.ibm.com>
	<20060110212551.411a766d.akpm@osdl.org>
	<1137007032.4395.24.camel@localhost.localdomain>
	<20060111114303.45540193.akpm@osdl.org>
	<1137201135.4353.81.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> On 2.6.14, the
> fall back io scheduler (if the chosen io scheduler is not found) is set
> to the default io scheduler (anticipatory, in this case), but since
> 2.6.15-rc1, this semanistic is changed to fall back to noop.

OK.  And I assume that AS wasn't compiled, so that's why it fell back?

I actually thought that elevator= got removed, now we have
/sys/block/sda/queue/scheduler.  But I guess that's not very useful with
CONFIG_SYSFS=n.

> Is there any reason to fall back to noop instead of as?  It seems
> anticipatory is much better than noop for ext3 with large sequential
> write tests (i.e, 1G dd test) ...

I suspect that was an accident.  Jens?
