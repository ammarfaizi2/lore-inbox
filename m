Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUB0CvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbUB0CvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:51:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:7558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261458AbUB0CvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:51:18 -0500
Date: Thu, 26 Feb 2004 18:51:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ben Collins <bcollins@debian.org>
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] SCSI host num allocation improvement
Message-Id: <20040226185154.5ec509ad.akpm@osdl.org>
In-Reply-To: <20040227023200.GA617@phunnypharm.org>
References: <20040226235412.GA819@phunnypharm.org>
	<20040226171928.750f5f6f.akpm@osdl.org>
	<20040226173743.2bf473b4.akpm@osdl.org>
	<20040227023200.GA617@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins <bcollins@debian.org> wrote:
>
> On Thu, Feb 26, 2004 at 05:37:43PM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > The lib/idr.c code is a bit clumsy but it does do the job relatively
> > > efficiently.
> > 
> > hmm, not too bad actually.  It compiles, but I didn't test it.
> 
> Oh, this isn't any good. It does the same thing as the old way. Steadily
> incrementing numbers.

In that case the idr_remove() was in the wrong place.  It was a wild guess.
