Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWBGSyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWBGSyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWBGSyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:54:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:25477 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932123AbWBGSyo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:54:44 -0500
Date: Wed, 8 Feb 2006 00:23:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, James.Bottomley@steeleye.com, mingo@elte.hu,
       axboe@suse.de, anton@samba.org, wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060207185355.GC5771@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com> <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org> <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org> <20060207183018.GA29056@in.ibm.com> <Pine.LNX.4.64.0602071036050.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602071036050.3854@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:43:55AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 8 Feb 2006, Dipankar Sarma wrote:
> > 
> > One would think so, but I recall not all archs did that. Alpha for
> > example sets up cpu_possible_map in smp_prepare_cpus(). It however
> > makes more sense to fix the arch then use NR_CPUS, IMO.
> 
> Ehh? alpha does it in setup_smp(), which in turn is called very early from 
> setup_arch().
> 
> Were you perhaps thinking of something else? Or am I just going blind and 
> confused?

I am looking at 2.6.16-rc1 and I don't see cpu_possible_map
being set in setup_smp(). That said, it seems alpha setup_smp()
probes for cpus there, so there is no reason why it cannot
be set there. I think it is wrong not to set cpu_possible_map
very early.

Or perhaps it got fixed later on, in which case, oh well, I need
to download more often. <sigh>.

Thanks
Dipankar
