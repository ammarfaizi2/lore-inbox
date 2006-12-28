Return-Path: <linux-kernel-owner+w=401wt.eu-S1754906AbWL1SFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbWL1SFq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 13:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbWL1SFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 13:05:46 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:2975 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896AbWL1SFp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 13:05:45 -0500
Date: Thu, 28 Dec 2006 19:05:36 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061228180536.GB7385@torres.zugschlus.de>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org> <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org> <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org> <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au> <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 09:51:49AM +0100, Marc Haber wrote:
> On Sun, Dec 17, 2006 at 09:43:08PM -0800, Andrew Morton wrote:
> > Six hours here of fsx-linux plus high memory pressure on SMP on 1k
> > blocksize ext3, mainline.  Zero failures.  It's unlikely that this testing
> > would pass, yet people running normal workloads are able to easily trigger
> > failures.  I suspect we're looking in the wrong place.
> 
> I do not have a clue about memory management at all, but is it
> possible that you're testing on a box with too much memory? My box has
> only 256 MB, and I used to use mutt with a _huge_ inbox with mutt
> taking somewhat 150 MB. Add spamassassin and a reasonably busy mail
> server, and the box used to be like 150 MB in swap.
> 
> I have tidied my inbox in the mean time and mutt's memory requirement
> has been reduced to somewhat 30 MB, which might be the cause that I
> don't see the issue that often any more.

After being up for ten days, I have now encountered the file
corruption of pkgcache.bin for the first time again. The 256 MB i386
box is like 26M in swap, is under very moderate load.

I am running plain vanilla 2.6.19.1. Is there a patch that I should
apply against 2.6.19.1 that would help in debugging?

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
