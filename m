Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWAXBi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWAXBi5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWAXBi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:38:57 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41901 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030286AbWAXBi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:38:57 -0500
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Tue, 24 Jan 2006 02:38:29 +0100
User-Agent: KMail/1.8.2
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>, Dave McCracken <dmccr@us.ibm.com>,
       Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601240210.04337.ak@suse.de> <20060124012331.GK1008@kvack.org>
In-Reply-To: <20060124012331.GK1008@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240238.29781.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 02:23, Benjamin LaHaise wrote:
> On Tue, Jan 24, 2006 at 02:10:03AM +0100, Andi Kleen wrote:
> > The randomization is not for cache coloring, but for security purposes
> > (except for the old very small stack randomization that was used
> > to avoid conflicts on HyperThreaded CPUs). I would be surprised if the
> > mmap made much difference because it's page aligned and at least
> > on x86 the L2 and larger caches are usually PI.
> 
> Actually, does this even affect executable segments?  Iirc, prelinking 
> already results in executables being mapped at the same physical offset 
> across binaries in a given system.  An strace seems to confirm that.

Shared libraries should be affected. And prelink is not always used.

-Andi
