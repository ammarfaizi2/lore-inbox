Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268706AbUIHEPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268706AbUIHEPd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268807AbUIHEPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:15:33 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:34500
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S268706AbUIHEP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:15:28 -0400
Date: Tue, 7 Sep 2004 21:12:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: willy@debian.org, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: multi-domain PCI and sysfs
Message-Id: <20040907211222.6184f14b.davem@davemloft.net>
In-Reply-To: <9e473391040907203941e4af81@mail.gmail.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	<200409041527.50136.jbarnes@engr.sgi.com>
	<9e47339104090415451c1f454f@mail.gmail.com>
	<200409041603.56324.jbarnes@engr.sgi.com>
	<20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	<9e473391040905165048798741@mail.gmail.com>
	<20040906014058.GV642@parcelfarce.linux.theplanet.co.uk>
	<9e47339104090715585fa4f8af@mail.gmail.com>
	<20040907161140.29fbfccc.davem@davemloft.net>
	<9e473391040907203941e4af81@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sep 2004 23:39:49 -0400
Jon Smirl <jonsmirl@gmail.com> wrote:

> On Tue, 7 Sep 2004 16:11:40 -0700, David S. Miller <davem@davemloft.net> wrote:
> > On Tue, 7 Sep 2004 18:58:53 -0400
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > > How many active VGA devices can I have in this system 1 or 4? If the
> > > answer is 4, how do I independently address each VGA card? If the
> > > answer is one, you can see why I want a pci0000 node to hold the
> > > attribute for turning it off and on.
> > 
> > I don't know about the above but for a multi-domain system the
> > way it works is that the I/O ports are accessed using a different
> > base address for each domain.
> 
> How does this work for IO ports in port space instead of memory mapped IO?

Those are IO ports in port space.  IO ports and PCI memory space just
live in different physical memory windows, no special instructions
for IO port space access as on x86.
