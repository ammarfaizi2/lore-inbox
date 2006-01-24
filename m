Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWAXB1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWAXB1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 20:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWAXB1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 20:27:46 -0500
Received: from kanga.kvack.org ([66.96.29.28]:60056 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1030285AbWAXB1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 20:27:45 -0500
Date: Mon, 23 Jan 2006 20:23:31 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@mpdtxmail.amd.com>, Dave McCracken <dmccr@us.ibm.com>,
       Robin Holt <holt@sgi.com>, Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060124012331.GK1008@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601240139.46751.ak@suse.de> <200601231853.54948.raybry@mpdtxmail.amd.com> <200601240210.04337.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601240210.04337.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 02:10:03AM +0100, Andi Kleen wrote:
> The randomization is not for cache coloring, but for security purposes
> (except for the old very small stack randomization that was used
> to avoid conflicts on HyperThreaded CPUs). I would be surprised if the
> mmap made much difference because it's page aligned and at least
> on x86 the L2 and larger caches are usually PI.

Actually, does this even affect executable segments?  Iirc, prelinking 
already results in executables being mapped at the same physical offset 
across binaries in a given system.  An strace seems to confirm that.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
