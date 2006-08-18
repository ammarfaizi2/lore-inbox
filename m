Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWHRS5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWHRS5u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWHRS5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:57:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:9363 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161074AbWHRS5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:57:33 -0400
To: Jens Axboe <axboe@suse.de>
Cc: David Chinner <dgc@sgi.com>, Neil Brown <neilb@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
References: <17633.2524.95912.960672@cse.unsw.edu.au>
	<20060815010611.7dc08fb1.akpm@osdl.org>
	<20060815230050.GB51703024@melbourne.sgi.com>
	<17635.60378.733953.956807@cse.unsw.edu.au>
	<20060816231448.cc71fde7.akpm@osdl.org>
	<20060818001102.GW51703024@melbourne.sgi.com>
	<20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2006 20:57:31 +0200
In-Reply-To: <20060818070314.GE798@suse.de>
Message-ID: <p73hd0998is.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Thu, Aug 17 2006, Andrew Morton wrote:
> > It seems that the many-writers-to-different-disks workloads don't happen
> > very often.  We know this because
> > 
> > a) The 2.4 performance is utterly awful, and I never saw anybody
> >    complain and
> 
> Talk to some of the people that used DVD-RAM devices (or other
> excruciatingly slow writers) on their system, and they would disagree
> violently :-)

I hit this recently while doing backups to a slow external USB disk.
The system was quite unusable (some commands blocked for over a minute)

-Andi
