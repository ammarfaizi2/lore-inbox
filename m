Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWC3Ikx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWC3Ikx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWC3Ikx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:40:53 -0500
Received: from ns1.siteground.net ([207.218.208.2]:63967 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751086AbWC3Ikx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:40:53 -0500
Date: Thu, 30 Mar 2006 00:41:42 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, Andrew Morton <akpm@osdl.org>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-ID: <20060330084142.GB3754@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp> <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com> <20060327131049.2c6a5413.akpm@osdl.org> <20060327225847.GC3756@localhost.localdomain> <1143530126.11560.6.camel@openx2.frec.bull.fr> <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com> <1143623605.5046.11.camel@openx2.frec.bull.fr> <1143657317.4045.12.camel@dyn9047017067.beaverton.ibm.com> <20060329200020.GA3729@localhost.localdomain> <1143664718.4045.76.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143664718.4045.76.camel@dyn9047017067.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 12:38:37PM -0800, Mingming Cao wrote:
> On Wed, 2006-03-29 at 12:00 -0800, Ravikiran G Thirumalai wrote:
> > On Wed, Mar 29, 2006 at 10:35:10AM -0800, Mingming Cao wrote:
> > 
> Wild suggestion, how about we don't update the global counter is the
> result is negative?

You mean just keep the local version even below -FBC_BATCH 
and only empty it to the global unsigned counter if the result is going to 
be +ve?  That would work I think.

Thanks,
Kiran
