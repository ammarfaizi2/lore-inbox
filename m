Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWDKWTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWDKWTR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWDKWTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:19:17 -0400
Received: from ns1.siteground.net ([207.218.208.2]:6375 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751157AbWDKWTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:19:16 -0400
Date: Tue, 11 Apr 2006 15:20:12 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] ext3 percpu counter fixes to suppport for ext3 unsigned long type free blocks counter
Message-ID: <20060411222012.GA5007@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com> <Pine.LNX.4.64.0604111007230.564@schroedinger.engr.sgi.com> <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144782073.3986.15.camel@dyn9047017067.beaverton.ibm.com>
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

On Tue, Apr 11, 2006 at 12:01:13PM -0700, Mingming Cao wrote:
> On Tue, 2006-04-11 at 10:09 -0700, Christoph Lameter wrote:
> > On Mon, 10 Apr 2006, Mingming Cao wrote:
> > 
> > > Here are the proposed patches to allow the ext3 free block accounting
> > > works with more than 8TB storage.
> > 
> > Umm.. This is an issue on 32 bit platforms only. 64bit platforms x86_64, 
> > ia64 etc do not need this. Would you make it arch specific?
> 
> Yes, make sense. I will update my patch soon. Thanks.

Or make the counter s64? so that it stays 64 bit on all arches? 

OR
why not change the global per-cpu counter type to unsigned long (as we
discussed earlier), so we don't need the extra "ul" flags and interfaces, 
and all arches get a standard unsigned long return type?  We could also 
do away with percpu_read_positive then no?  The applications for per-cpu 
counters is going to be upcounters always methinks...

Thanks,
Kiran
