Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVAYMA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVAYMA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 07:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVAYMA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 07:00:27 -0500
Received: from colin2.muc.de ([193.149.48.15]:10256 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261908AbVAYMAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 07:00:24 -0500
Date: 25 Jan 2005 13:00:23 +0100
Date: Tue, 25 Jan 2005 13:00:23 +0100
From: Andi Kleen <ak@muc.de>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Nathan Scott <nathans@sgi.com>, Mike Waychison <Michael.Waychison@sun.com>,
       Jesper Juhl <juhl-lkml@dif.dk>, Felipe Alfaro Solana <lkml@mac.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>,
       Tim Hockin <thockin@hockin.org>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050125120023.GA8067@muc.de>
References: <20050122203326.402087000@blunzn.suse.de> <41F570F3.3020306@sun.com> <20050125065157.GA8297@muc.de> <200501251112.46476.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501251112.46476.agruen@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would slow down the groups case (unless we leave the specialized version 
> in). Gcc doesn't inline a cmp function pointer, and a C preprocessor 
> templatized version would be really ugly. A variant with of this routine with 
> qsort like interface should be good enough for nfsacl and xfs though.

group initialization is not time critical, it typically only happens
at login.  Also it's doubleful you'll even be able to measure the difference.

-Andi
