Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbTHSSoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbTHSSnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:43:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59788 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261191AbTHSSi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:38:29 -0400
Date: Tue, 19 Aug 2003 11:31:20 -0700
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jes@wildopensource.com, zaitcev@redhat.com, khc@pm.waw.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RFC: kills consistent_dma_mask
Message-Id: <20030819113120.7ac55d54.davem@redhat.com>
In-Reply-To: <1061317998.30567.44.camel@dhcp23.swansea.linux.org.uk>
References: <m3oeynykuu.fsf@defiant.pm.waw.pl>
	<20030818111522.A12835@devserv.devel.redhat.com>
	<m33cfyt3x6.fsf@trained-monkey.org>
	<1061298438.30566.29.camel@dhcp23.swansea.linux.org.uk>
	<20030819095547.2bf549e3.davem@redhat.com>
	<1061317998.30567.44.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Aug 2003 19:33:19 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-08-19 at 17:55, David S. Miller wrote:
> > (d) Makes implementations have to verify the mask is usable
> > on every mapping attempt.
> 
> Or once per type with a bit of thought about it. I deal with
> hardware that has 2 limits on its consistent allocs and a
> different one with its streaming I/O buffers. It doesn't seem
> too atypical either

Are you talking on the platform or the PCI device side?

If on the platform side, the device wants to use the most
capable range/mask/whatever available that also fits it's
limits.

If on the PCI device side, it's also a best fit problem.

Give a specific example so I can map this out in my head.
