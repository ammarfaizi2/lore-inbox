Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUIMQPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUIMQPo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUIMQNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:13:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:7610 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266295AbUIMQK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:10:59 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0409131113240.5077@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <Pine.LNX.4.58.0409100209100.32064@skynet>
	 <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <20040910153135.4310c13a.felix@trabant>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
	 <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
	 <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>
	 <1095083862.14587.18.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0409131113240.5077@node2.an-vo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095088021.14587.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 13 Sep 2004 16:07:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-13 at 16:20, Vladimir Dergachev wrote:
> > It depends how the various components fit together. Clearly for Radeon
> > you want everyone using the DMA command path when DRI is loaded. That
> > doesn't require "one driver"
> 
> Alan, do I understand right that you are proposing to have two pieces of 
> code in the framebuffer - one that can program the card in the absence of 
> DRM driver and one that uses CP when it is present ?

We could do, or the DRM driver could provide DMA methods for the
framebuffer driver to use. I mean it might be that we should always be
using DMA methods in all the drivers for radeon all the time anyway  ?

The fb driver gets told when DRI comes and goes which means the two can
choose to co-operate if they wish.

