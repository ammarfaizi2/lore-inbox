Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263600AbUEGO1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263600AbUEGO1w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 10:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbUEGOZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 10:25:43 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:12928 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263600AbUEGOZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 10:25:12 -0400
Date: Thu, 6 May 2004 17:06:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marc Boucher <marc@linuxant.com>
Cc: Timothy Miller <miller@techsource.com>, Rik van Riel <riel@redhat.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040506150628.GB183@elf.ucw.cz>
References: <Pine.LNX.4.44.0404281958310.19633-100000@chimarrao.boston.redhat.com> <40911C01.80609@techsource.com> <20040429213246.GA15988@valve.mbsi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429213246.GA15988@valve.mbsi.ca>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Can you honestly tell apart the two cases, if you don't make a it a case of
> > "religion war"?
> 
> On Thu, Apr 29, 2004 at 11:15:13AM -0400, Timothy Miller answered:
> >
> > Firmware downloaded into a piece of hardware can't corrupt the kernel in the
> > host.
> > 
> > (Unless it's a bus master which writes to random memory, which might be
> > possible, but there is hardware you can buy to watch PCI transactions.)
> 
> and unless it's a card with binary-only, proprietary BIOS code called at
> runtime by the kernel, for example by the vesafb.c video driver,
> which despite this has a MODULE_LICENSE("GPL").

> Could someone explain why such execution of evil proprietary binary-only
> code on the host CPU should not also "taint" the kernel? ;-)

Well, it only does so if you try to do fast scrolling or palette
operations... which most people won't do.

Actually separate taint flag for this might make sense... and when
buggy vesa bios appears we'll probably add it.
								Pavel
-- 
When do you have heart between your knees?
