Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbTIKQbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbTIKQbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:31:39 -0400
Received: from ns.suse.de ([195.135.220.2]:31184 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261372AbTIKQbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:31:38 -0400
Date: Thu, 11 Sep 2003 18:31:36 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-Id: <20030911183136.01dfeb53.ak@suse.de>
In-Reply-To: <20030911162504.GL21596@parcelfarce.linux.theplanet.co.uk>
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	<p73oexri9kx.fsf@oldwotan.suse.de>
	<20030911162504.GL21596@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 17:25:04 +0100
Matthew Wilcox <willy@debian.org> wrote:

> On Thu, Sep 11, 2003 at 06:17:02PM +0200, Andi Kleen wrote:
> > The overhead of checking for PIO vs mmio at runtime in the drivers
> > should be completely in the noise on any non ancient CPU (both MMIO
> > and PIO typically take hundreds or thousands of CPU cycles for the bus
> > access, having an dynamic function call or an if before that is makes
> > no difference at all)
> 
> That's not true for MMIO writes which are posted.  They should take
> no longer than a memory write.  For MMIO reads and PIO reads & writes,
> you are, of course, correct.

Even a memory write is tens to hundres of cycles.

-Andi

