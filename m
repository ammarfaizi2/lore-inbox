Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbTANFwr>; Tue, 14 Jan 2003 00:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTANFwq>; Tue, 14 Jan 2003 00:52:46 -0500
Received: from havoc.daloft.com ([64.213.145.173]:3301 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267453AbTANFwq>;
	Tue, 14 Jan 2003 00:52:46 -0500
Date: Tue, 14 Jan 2003 01:01:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Louis Zhuang <louis.zhuang@linux.co.intel.com>
Cc: jgarzik@redhat.com, scott.feldman@intel.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG FIX] e100 initialization issue on STL2 motherboard
Message-ID: <20030114060130.GA10631@gtf.org>
References: <1042523515.3951.12.camel@hawk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042523515.3951.12.camel@hawk.sh.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 01:51:55PM +0800, Louis Zhuang wrote:
> 	The patch will increase waiting time in SCB initialization. It will
> resolve the issue on STL2 motherboard. Pls apply. 

Sorry, not applied.

I was kinda hoping Scott would fix that up.  It is a verified problem
(SMBus timeout, IIRC?), and this does indeed fix the problem.

However one should not udelay() that long -- especially in this case.
Since it is during init, sleep using schedule_timeout() for as long as
you want...


> begin 664 bkpatch4832

Please do not bother with sending BK patches like this.  Either send
just the diff, as you did (thanks), or in addition send a URL from which
I may issue

	bk pull $url

Regards,

	Jeff




