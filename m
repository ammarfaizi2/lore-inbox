Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVLLRqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVLLRqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVLLRqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:46:33 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:50407 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750799AbVLLRqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:46:32 -0500
Subject: Re: Fw: crash on x86_64 - mm related?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ryan Richter <ryan@tau.solarneutrino.net>, Hugh Dickins <hugh@veritas.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
References: <20051201195657.GB7236@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com>
	 <20051202180326.GB7634@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com>
	 <20051202194447.GA7679@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
	 <20051206160815.GC11560@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512062025230.28217@goblin.wat.veritas.com>
	 <20051206204336.GA12248@tau.solarneutrino.net>
	 <Pine.LNX.4.61.0512071803300.2975@goblin.wat.veritas.com>
	 <20051212165443.GD17295@tau.solarneutrino.net>
	 <Pine.LNX.4.64.0512120928110.15597@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 11:45:30 -0600
Message-Id: <1134409531.9994.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 09:40 -0800, Linus Torvalds wrote:
> I think it's the "sdev->single_lun" test at the very top of the function, 
> where "sdev" was initialized with "q->queuedata". So it looks like 
> somebody free'd the request_queue structure before the IO completed.
> 
> Definitely sounds like something screwy in SCSI.. I don't think this is VM 
> related.

Welcome back home.

This is that SCSI patch you reversed just before you went away.  If you
put it back again, the problem will go away ...

James


