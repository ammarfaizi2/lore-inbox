Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUC3Lkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 06:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbUC3Lkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 06:40:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:465 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263823AbUC3Lkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 06:40:40 -0500
Date: Tue, 30 Mar 2004 13:40:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Kurt Garloff <garloff@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040330114038.GT24370@suse.de>
References: <20040328175436.GL24370@suse.de> <20040328180809.GB1087@mail.shareable.org> <20040328181502.GO24370@suse.de> <40671FAF.6080501@pobox.com> <20040329080943.GR24370@suse.de> <20040329124147.GC4984@mail.shareable.org> <20040329124421.GB24370@suse.de> <1080565536.3570.4.camel@laptop.fenrus.com> <20040329130850.GD24370@suse.de> <20040330081301.GA3820@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330081301.GA3820@tpkurt.garloff.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30 2004, Kurt Garloff wrote:
> On Mon, Mar 29, 2004 at 03:08:50PM +0200, Jens Axboe wrote:
> > Indeed, it would be best to keep the read-ahead window at least a
> > multiple of the max read size. So you don't get the nasty effects of
> > having a 128k read-ahead window, but device with 255 sector limit
> > resulting in 124KB + 4KB read.
> 
> Any work underway to implement this?

It would be a few lines of code to implement this - see the other patch
I just sent. You just need to adjust backing_dev_info.ra_pages based on
->max_sectors, if you use the current kernels.

-- 
Jens Axboe

