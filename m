Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269309AbUIHS7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269309AbUIHS7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 14:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbUIHS7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 14:59:38 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61640
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S269309AbUIHS5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 14:57:52 -0400
Date: Wed, 8 Sep 2004 11:54:41 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: jonsmirl@gmail.com, willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: multi-domain PCI and sysfs
Message-Id: <20040908115441.1fa84be0.davem@davemloft.net>
In-Reply-To: <200409081132.29008.jbarnes@engr.sgi.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	<200409080902.14640.jbarnes@engr.sgi.com>
	<20040908112027.545a6b2e.davem@davemloft.net>
	<200409081132.29008.jbarnes@engr.sgi.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004 11:32:28 -0700
Jesse Barnes <jbarnes@engr.sgi.com> wrote:

> On Wednesday, September 8, 2004 11:20 am, David S. Miller wrote:
> > On Wed, 8 Sep 2004 09:02:14 -0700
> >
> > Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > > Where is the PCI segment base address stored in the PCI driver
> > > > structures? I'm still having trouble with the fact that the PCI driver
> > > > does not have a clear structure representing a PCI segment.  Shouldn't
> > > > there be a structure corresponding to a segment?
> > >
> > > That would be nice, maybe an extra resource or something?  I haven't
> > > looked at the sparc code, but it probably deals with this (sn2 has
> > > platform specific functions to get the base address for a bus).
> >
> > We store them directly in pci_resource_*(pdev,BAR_NUM) as physical
> > addresses.
> 
> Oh, right, you have them stored in each bridge, right?  I should do the same 
> thing for sn2...

Oh you mean the base of the entire I/O space?  We store that in the
pdev arch level private area.

