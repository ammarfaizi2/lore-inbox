Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUG3Gir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUG3Gir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 02:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUG3Gir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 02:38:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:30128 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267625AbUG3Gio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 02:38:44 -0400
Date: Fri, 30 Jul 2004 08:38:35 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@ximian.com>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>,
       Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040730063834.GG18347@suse.de>
References: <20040728145543.GB18846@devserv.devel.redhat.com> <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de> <1091051858.13651.1.camel@camp4.serpentine.com> <20040729084928.GR10377@suse.de> <1091166553.1982.9.camel@localhost> <20040730055333.GC7925@suse.de> <1091167031.1982.13.camel@localhost> <20040730061005.GF18347@suse.de> <1091168884.2009.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091168884.2009.1.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30 2004, Robert Love wrote:
> On Fri, 2004-07-30 at 08:10 +0200, Jens Axboe wrote:
> 
> > Strange, something else must be accessing the drive at the same time.
> 
> Don't see anything.

There must be something if you have the buffer io errors and matching
sector number.

> > If it's just playback, don't bother.
> 
> Did not work anyhow.
> 
> > So the question is - what else is accessing the drive?
> 
> Nothing but the CD player - it is doing CDDB, though, so that is where
> the reads are coming from.

CDDB lookups don't generate io to the drive (apart from that it already
grabbed to show you the toc).

> It works/fails consistently - for example, I have one CD that never
> works and one CD that does, as if the CD is physically damaged.  Works
> elsewhere, though.

And the CD that never works, is that consistent across different drives?

-- 
Jens Axboe

