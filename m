Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266317AbUFRRiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUFRRiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUFRRiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:38:11 -0400
Received: from gw.compusonic.fi ([195.255.196.126]:490 "EHLO gw.compusonic.fi")
	by vger.kernel.org with ESMTP id S266317AbUFRRhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:37:54 -0400
Date: Fri, 18 Jun 2004 20:37:53 +0300 (EEST)
From: Hannu Savolainen <hannu@opensound.com>
X-X-Sender: hannu@zeus.compusonic.fi
To: Roman Zippel <zippel@linux-m68k.org>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <Pine.LNX.4.58.0406181205500.13079@scrub.local>
Message-ID: <Pine.LNX.4.58.0406182006060.20336@zeus.compusonic.fi>
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk>
 <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local>
 <40D2464D.2060202@opensound.com> <Pine.LNX.4.58.0406181205500.13079@scrub.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Roman Zippel wrote:

> To quote from your previous mail:
>
> > make -C /lib/modules/`uname -r`/build scripts scripts_basic include/linux/version.h
>
> That doesn't really like documented interfaces to me.
Right. The documented command is "make install". However an undocumented
detail is that that doesn't work with "virgin" kernel sources (nothing
compiled yet). The above command seems to be needed to prepare the source
tree for building the module. The "documented" alternative would be full
make in the kernel source tree but that is massive overkill (in addition
it doesn't work with most distribution kernels).

The actual problem is that there is no standardized way to compile modules
outside the kernel source tree. There will be serious problems if
different distributions need slightly different installation procedure.
Who is going to be able to tell the customer what exactly he should do?

So even as hardware vendor releases an open source drivers for their
hardware nobody can use them before the driver gets included to the
distribution kernels. Ok, this is not a problem as long as every single
driver for every single device in the world is included in the kernel.
However I bet this will break kernel (and distribution) maintainers' necks
within not so many years.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM
