Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbUKDKIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbUKDKIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbUKDKIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:08:00 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:33989 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262153AbUKDKHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:07:53 -0500
Date: Thu, 4 Nov 2004 11:07:49 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104100749.GA23996@merlin.emma.line.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200411030751.39578.gene.heskett@verizon.net> <200411031124.19179.gene.heskett@verizon.net> <20041103201322.GA10816@hh.idb.hist.no> <200411031540.03598.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411031540.03598.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Nov 2004, Gene Heskett wrote:

> >Yes it does - the problem is that not all resources are managed
> >by processes.  Some allocations are managed by drivers, so a driver
> >bug can get the device into a unuseable state _and_ tie up the
> >process(es) that were using the driver at the moment.
> 
> This from my viewpoint, is wrong.  The kernel, and only the kernel 
> should be ultimately responsible for handing out resources, and 
> reclaiming at its convienience.

Linux's driver model is the way it is. If you want the kernel to clean
up after a driver has puked, you need something like a microkernel I
believe, where only a minimal core kernel is a real kernel and where all
the drivers are actually in user-space, but that's no longer Linux then.

I'm not reflecting the down- and upsides to of this as I have no
experience with microkernels (and have never used OS9 or GNU Hurd
either). I know there have been attempts to port Linux to a Microkernel
but I don't know what's come out of it.

-- 
Matthias Andree
