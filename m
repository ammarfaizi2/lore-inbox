Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVA1GpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVA1GpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 01:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVA1GpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 01:45:08 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:52627 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S261485AbVA1GpD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 01:45:03 -0500
Date: Fri, 28 Jan 2005 07:44:58 +0100
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Ake <Ake.Sandgren@hpc2n.umu.se>, linux-kernel@vger.kernel.org,
       Rik van Riel <riel@redhat.com>
Subject: Re: Bug in 2.4.26 in mm/filemap.c when using RLIMIT_RSS
Message-ID: <20050128064458.GB12325@hpc2n.umu.se>
References: <20050126110750.GE7349@hpc2n.umu.se> <20050126144904.GE26308@logos.cnet> <20050127063849.GA11119@hpc2n.umu.se> <20050127074459.GH26308@logos.cnet> <Pine.LNX.4.61.0501281502540.10979@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281502540.10979@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.6+20040907i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 03:09:40PM +0000, Hugh Dickins wrote:
> > > BTW do you know if there is any plans for 2.6++ to actually use
> > > RLIMIT_RSS? I saw a hint in that direction in mm/thrash.c
> > > grab_swap_token but it is commented out and only skeleton code...
> > 
> > Nope, RLIMIT_RSS does not seem to be used at all in v2.6:
> > 
> > Its there for compatibility reasons, support for it might be added
> > in the future?
> 
> Rik had a patch implementing RLIMIT_RSS in 2.6-mm for a while.
> But I think there were a couple of problems with it, and no great
> demand for the feature, so Andrew dropped it until someone makes
> a better case for it.

Well, the use for it is for compute clusters where you really would like
to be able to limit this. Esp on smp boxes where there is multiple
compute jobs running simultaneously. Be it mpi or separate jobs you
really want to limit their RSS use so they don't steal memory from each
other.

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
