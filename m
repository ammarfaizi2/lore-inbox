Return-Path: <linux-kernel-owner+w=401wt.eu-S1751365AbXAPUKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbXAPUKz (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 15:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAPUKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 15:10:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49098 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751365AbXAPUKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 15:10:54 -0500
Date: Tue, 16 Jan 2007 12:10:38 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: akpm@osdl.org, Paul Menage <menage@google.com>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [RFC 0/8] Cpuset aware writeback
In-Reply-To: <1168933090.22935.30.camel@twins>
Message-ID: <Pine.LNX.4.64.0701161208590.2905@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <1168933090.22935.30.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Peter Zijlstra wrote:

> > B. We add a new counter NR_UNRECLAIMABLE that is subtracted
> >    from the available pages in a node. This allows us to
> >    accurately calculate the dirty ratio even if large portions
> >    of the node have been allocated for huge pages or for
> >    slab pages.
> 
> What about mlock'ed pages?

mlocked pages can be dirty and written back right? So for the
dirty ratio calculation they do not play a role. We may need a
separate counter for mlocked pages if they are to be considered
for other decisions in the VM.

> Otherwise it all looks good.
> 
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Thanks.
