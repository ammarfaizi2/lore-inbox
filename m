Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWH1UT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWH1UT6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWH1UT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:19:58 -0400
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:48845 "EHLO
	p02c11o142.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751471AbWH1UT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:19:57 -0400
Date: Mon, 28 Aug 2006 23:19:34 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: T60 not coming out of suspend to RAM
Message-ID: <20060828201934.GA26544@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060828122535.911e593a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828122535.911e593a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 28 Aug 2006 20:25:53.0500 (UTC) FILETIME=[28F0E9C0:01C6CAE0]
X-Spam: [F=0.0100000000; S=0.010(2006081701)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Andrew Morton <akpm@osdl.org>:
> Subject: Re: T60 not coming out of suspend to RAM
> 
> On Mon, 28 Aug 2006 20:19:26 +0300
> "Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
> 
> > Quoting r. Pavel Machek <pavel@ucw.cz>:
> > > Subject: Re: T60 not coming out of suspend to RAM
> > > 
> > > On Mon 2006-08-28 16:53:58, Michael S. Tsirkin wrote:
> > > > OK, it turns out the problem was with running SATA drive in AHCI mode.
> > > > 
> > > > After applying the following patch from Forrest Zhao
> > > > http://lkml.org/lkml/2006/7/20/56
> > > > both suspend to disk and suspend to ram work fine now.
> > > > This patch is going into 2.6.18, isn't it?
> > > 
> > > Not sure, check latest -rc5, and if it is not there, ask akpm...
> > > 
> > 
> > Andrew, this is going into 2.6.18, isn't it? I don't see it in -rc5.
> > 
> 
> It looks like Forrest's stuff is all queued up in the libata devel tree,
> although in a significantly different-looking form.
> 
> So no, right now it doesn't look good for 2.6.18.
> 

Ugh, more's the pity :(
How about merging this one patch? T60 is only half as useful without it (no disk
after resume), and the rate of changes in libata is high so just using a patch
is gonnu be painful in the long run.

-- 
MST
