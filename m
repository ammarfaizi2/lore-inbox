Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUIDXGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUIDXGH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 19:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUIDXGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 19:06:04 -0400
Received: from pop.gmx.de ([213.165.64.20]:43394 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264396AbUIDXFp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 19:05:45 -0400
X-Authenticated: #7318305
Date: Sun, 5 Sep 2004 01:08:00 +0200
From: Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>
To: Dave Airlie <airlied@linux.ie>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
Message-Id: <20040905010800.08c58a38.felix@trabant>
In-Reply-To: <Pine.LNX.4.58.0409042311270.24528@skynet>
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com>
	<Pine.LNX.4.58.0409040145240.25475@skynet>
	<20040904102914.B13149@infradead.org>
	<41398EBD.2040900@tungstengraphics.com>
	<20040904104834.B13362@infradead.org>
	<413997A7.9060406@tungstengraphics.com>
	<20040904112535.A13750@infradead.org>
	<4139995E.5030505@tungstengraphics.com>
	<20040904112930.GB2785@redhat.com>
	<4139A9F4.4040702@tungstengraphics.com>
	<20040904115442.GD2785@redhat.com>
	<4139B03A.6040706@tungstengraphics.com>
	<Pine.LNX.4.58.0409041311020.25475@skynet>
	<1094301014.2801.10.camel@laptop.fenrus.com>
	<Pine.LNX.4.58.0409041333230.25475@skynet>
	<Pine.LNX.4.58.0409042311270.24528@skynet>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I realized, that from a snapshot point of view, it would be easy to cope
with a separate library module + additional binary interface. As far as
I gathered the main argument against another binary interface is that
upgrading one driver would break the other ones that may still be
installed on the system. It would be no problem to update all of them at
the same time. The snapshots include all the DRM sources anyway, they
just build the DRM for a single type of card right now.

The snapshots have been split into a common and a hardware-specific part
some time ago. Just move the DRM into the common part of the snapshots
and make it build and upgrade all DRM drivers at the same time. This way
a change in the binary interface won't break any other drivers (provided
that DRM CVS is the authoritative source for *all* DRM drivers that rely
on that library module).

Regards,
  Felix

On Sat, 4 Sep 2004 23:17:40 +0100 (IST)
Dave Airlie <airlied@linux.ie> wrote:

> 
> Actually after sleeping on this, I've just realised technically whether
> the code is in a core separate module or driver module is only going to
> affect maybe 5% of the work and the Makefiles/Kconfig at the end, so
> following the principles of a)least surprise, b) kernel must remain
> stable, I think I can proceed with moving stuff into libraries and the
> likes without making the final decision until later, we will probably
> start with having the library type code in the driver (where it is now)
> and make it possible to change later, as it evolves..
> 
> I'll do some more research...
> 
> Dave.
> 

| Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
| PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |
