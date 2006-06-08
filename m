Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbWFHOAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWFHOAS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWFHOAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:00:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55831 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964819AbWFHOAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:00:16 -0400
Date: Thu, 8 Jun 2006 16:00:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Voluspa <lista1@comhem.se>, akpm@osdl.org, Valdis.Kletnieks@vt.edu,
       diegocg@gmail.com, linux-kernel@vger.kernel.org, wfg@mail.ustc.edu.cn
Subject: Re: adaptive readahead overheads
Message-ID: <20060608140012.GD5207@suse.de>
References: <349406446.10828@ustc.edu.cn> <20060604020738.31f43cb0.akpm@osdl.org> <1149413103.3109.90.camel@laptopd505.fenrus.org> <20060605031720.0017ae5e.lista1@comhem.se> <349562623.17723@ustc.edu.cn> <20060608094356.5c1272cc.lista1@comhem.se> <349766648.27054@ustc.edu.cn> <20060608142556.2e10e379.lista1@comhem.se> <p73ac8nu7a5.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73ac8nu7a5.fsf@verdi.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08 2006, Andi Kleen wrote:
> Voluspa <lista1@comhem.se> writes:
> 
> > On Thu, 8 Jun 2006 19:37:31 +0800 Fengguang Wu wrote:
> > > I'd like to show some numbers on the pure software overheads come with
> > > the adaptive readahead in daily operations.
> > [...]
> > > 
> > > # time find /usr -type f -exec md5sum {} \; >/dev/null
> > > 
> > > ARA
> > > 
> > > 406.00s user 325.16s system 97% cpu 12:28.17 total
> > 
> > Just out of interest, all your figures show an almost maxed out CPU.
> 
> It might be because qemu has a poor IO model (old IDE) that is quite 
> CPU intensive to drive.

qemu ide supports dma, so it's ok in that respect. It doesn't support
async io for the host though, so all io ends up blocking waiting for io
to complete at the host. I would not advocate using qemu for benching
these things, it's just not (yet) well suited for io testing.

-- 
Jens Axboe

