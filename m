Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263203AbUKUEJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbUKUEJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 23:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKUEJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 23:09:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:35729 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263208AbUKUEJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 23:09:33 -0500
Date: Sat, 20 Nov 2004 20:08:56 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] visor: Always do generic_startup
Message-ID: <20041121040856.GB1569@kroah.com>
References: <20041116154943.GA13874@k3.hellgate.ch> <20041119174405.GE20162@kroah.com> <20041121012353.GA4008@himi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121012353.GA4008@himi.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 12:23:53PM +1100, Simon Fowler wrote:
> On Fri, Nov 19, 2004 at 09:44:05AM -0800, Greg KH wrote:
> > On Tue, Nov 16, 2004 at 04:49:43PM +0100, Roger Luethi wrote:
> > > generic_startup in visor.c was not called for some hardware, resulting
> > > in attempts to access memory that had never been allocated, which in
> > > turn caused the problem several people reported with recent (2.6.10ish)
> > > kernels.
> > > 
> > > Signed-off-by: Roger Luethi <rl@hellgate.ch>
> > 
> > Thanks for finding this.
> > 
> > Applied.
> > 
> This patch fixes the oops, but after applying it I can no longer
> sync my palm 5 - it starts, but part way through the connection is
> lost.

Can you enable debugging in the visor driver (either through the
modprobe paramater, or through the /sys/module/paramater/debug file, and
send it to us?

thanks,

greg k-h
