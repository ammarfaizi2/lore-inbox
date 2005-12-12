Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVLLSE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVLLSE1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbVLLSE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:04:27 -0500
Received: from solarneutrino.net ([66.199.224.43]:33798 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932156AbVLLSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:04:25 -0500
Date: Mon, 12 Dec 2005 13:04:19 -0500
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051212180419.GA18508@tau.solarneutrino.net>
References: <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com> <20051206160815.GC11560@tau.solarneutrino.net> <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com> <20051206204336.GA12248@tau.solarneutrino.net> <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com> <20051212165443.GD17295@tau.solarneutrino.net> <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org> <1134409531.9994.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134409531.9994.13.camel@mulgrave>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 11:45:30AM -0600, James Bottomley wrote:
> On Mon, 2005-12-12 at 09:40 -0800, Linus Torvalds wrote:
> > I think it's the "sdev->single_lun" test at the very top of the
> > function, where "sdev" was initialized with "q->queuedata". So it
> > looks like somebody free'd the request_queue structure before the IO
> > completed.
> > 
> > Definitely sounds like something screwy in SCSI.. I don't think this
> > is VM related.

That was just a stupid guess to get someone's attention :)

> Welcome back home.
> 
> This is that SCSI patch you reversed just before you went away.  If
> you put it back again, the problem will go away ...
> 

Should I try this patch out?  If so, where can I find it?

Thanks,
-ryan
