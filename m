Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267094AbUBRB3j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267099AbUBRB3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:29:39 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:4368 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S267094AbUBRB3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:29:37 -0500
Date: Wed, 18 Feb 2004 02:28:53 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Adrian Bunk <bunk@fs.tum.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, GCS <gcs@lsc.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, vandrove@vc.cvut.cz
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <20040218000028.GR1308@fs.tum.de>
Message-ID: <Pine.LNX.4.58.0402180213500.7851@serv>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu> <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
 <20040217200545.GP1308@fs.tum.de> <Pine.LNX.4.58.0402171214230.2154@home.osdl.org>
 <20040217225905.GQ1308@fs.tum.de> <Pine.LNX.4.58.0402171503150.2154@home.osdl.org>
 <20040218000028.GR1308@fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 18 Feb 2004, Adrian Bunk wrote:

> > Basically, if you compile radeonfb as a module, and say "Y" to RADEON_I2C,
> > then that should _not_ force I2C to be built-in to the kernel, but that
> > is in fact exactly what this would force.
> >...
>
> I don't claim to fully understand the 2.6 Kconfig language, but
> according to my testings my patch does exactly what you describe.

It does that more by accident. I actually consider it an error that the
dependency of boolean symbol modifies how it does the selection (note that
the dependencies can be more than is immediately visible, e.g. from an
'if' or a 'menu' block), so I prefer if one want to limit the selection of
a boolean symbol to make this explicit (via an 'if' condition after the
selection).

bye, Roman
