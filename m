Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVBYJds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVBYJds (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 04:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVBYJds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 04:33:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4783 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262652AbVBYJdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 04:33:46 -0500
Subject: Re: [2.6 patch] unexport do_settimeofday
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050225092640.GS27352@schnapps.adilger.int>
References: <20050224233742.GR8651@stusta.de>
	 <20050224212448.367af4be.akpm@osdl.org>
	 <1109318525.6290.32.camel@laptopd505.fenrus.org>
	 <20050225002804.4905b649.akpm@osdl.org>
	 <58cb370e050225004759e1dc59@mail.gmail.com>
	 <20050225092640.GS27352@schnapps.adilger.int>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 10:33:37 +0100
Message-Id: <1109324017.6290.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 02:26 -0700, Andreas Dilger wrote:
> On Feb 25, 2005  09:47 +0100, Bartlomiej Zolnierkiewicz wrote:
> > On Fri, 25 Feb 2005 00:28:04 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >  I haven't found any possible modular usage of do_settimeofday in the
> > > >  kernel.
> > > 
> > > Sure.  But there must have been a reason to export it in the first place.
> > 
> > sloppy coding?
> 
> Who knows?  Maybe someone developed a kernel module that interfaces to an
> unusual clock chip on their motherboard.  IMHO, all of this "_I_ don't
> see any use for it, lets get rid of it because it's not useful" changing
> is just a source of grief for anyone that doesn't have their code in
> the kernel.

actually exports cause kernels to be bigger. Some of these exports
aren't even used in the kernel entirely, others cause the kernel to be
bigger just by being non-static and having the symbol structures there.
A lot of them are "you really shouldn't" APIs.

By your argument, why bother with exports at all?


