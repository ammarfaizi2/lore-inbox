Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVAYMFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVAYMFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVAYMFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:05:13 -0500
Received: from ns.suse.de ([195.135.220.2]:8864 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261911AbVAYMFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:05:09 -0500
Date: Tue, 25 Jan 2005 13:05:07 +0100
From: Olaf Kirch <okir@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Andreas Gruenbacher <agruen@suse.de>, Nathan Scott <nathans@sgi.com>,
       Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Tim Hockin <thockin@hockin.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050125120507.GH19199@suse.de>
References: <20050122203326.402087000@blunzn.suse.de> <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de> <200501251112.46476.agruen@suse.de> <20050125120023.GA8067@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125120023.GA8067@muc.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 01:00:23PM +0100, Andi Kleen wrote:
> group initialization is not time critical, it typically only happens
> at login.  Also it's doubleful you'll even be able to measure the difference.

nfsd updates its group list for every request it processes, so you don't want
to make that too slow.

Olaf
-- 
Olaf Kirch     | Things that make Monday morning interesting, #2:
okir@suse.de   |        "We have 8,000 NFS mount points, why do we keep
---------------+ 	 running out of privileged ports?"
