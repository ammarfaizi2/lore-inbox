Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267385AbTA1PNT>; Tue, 28 Jan 2003 10:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267387AbTA1PNT>; Tue, 28 Jan 2003 10:13:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11855 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267385AbTA1PNS>; Tue, 28 Jan 2003 10:13:18 -0500
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: kexec reboot code buffer
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org>
	<3E35AAE4.10204@us.ibm.com> <m1r8ax69ho.fsf@frodo.biederman.org>
	<20030128071826.GI780@holomorphy.com>
	<m1isw968e3.fsf@frodo.biederman.org>
	<20030128073117.GJ780@holomorphy.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jan 2003 08:21:23 -0700
In-Reply-To: <20030128073117.GJ780@holomorphy.com>
Message-ID: <m1el6x5mh8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> William Lee Irwin III <wli@holomorphy.com> writes:
> >> Seriously, just plop down the fresh zone type and all will be well.
> >> It's really incredibly easy.
> 
> On Tue, Jan 28, 2003 at 12:28:04AM -0700, Eric W. Biederman wrote:
> > I will certainly take a look, tracing through that code can get a little
> > hairy.
> 
> It can really be approached much more cavalierly than that. The only
> extant example aside from the original ZONE_DMA32 implementation I've
> seen is Simon Winwood's MPSS patch, which needed something on the order
> of 10 lines of code for a fresh zone type (for one arch).
> 
> And most of the bulk of the ZONE_DMA32 implementation was stringing up
> the block layer to utilize it, not inserting the new zone type itself.

Primarily it appears that just another ZONE needs to be added, and then
free_area_init needs to be passed the proper parameters.  

I still want to look closely at how the discontig mem case for NUMA is
setup.  It is probably nothing to worry about but I want to make
certain it does not have any perverse behavior and also I want to be
certain I know how to setup a NUMA system properly, since I am looking
at the code anyway.

Eric
