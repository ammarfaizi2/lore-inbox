Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUHVPuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUHVPuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267529AbUHVPuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 11:50:23 -0400
Received: from the-village.bc.nu ([81.2.110.252]:23439 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267474AbUHVPuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 11:50:20 -0400
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, eich@suse.de
In-Reply-To: <20040822142344.GA81458@muc.de>
References: <2vEzI-Vw-17@gated-at.bofh.it>
	 <m3n00nwepr.fsf@averell.firstfloor.org>
	 <1093176046.24272.68.camel@localhost.localdomain>
	 <20040822142344.GA81458@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093186067.24609.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 15:47:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 15:23, Andi Kleen wrote:
> > The actual code is:
> > 
> >        if (ioperm(0, 1024, 1) || iopl(3))
> >                 FatalError("xf86EnableIOPorts: Failed to set IOPL for
> > I/O\n")
> > 
> > (os-support/linux/lnx_video.c:xf86EnableIO)
> > 
> > Flip those around and rebuild.
> 
> It would be better to do that in the official release.

The current release is in final code freeze so such a change would need
the release wranglers agreement, I can't just go checking it into the
tree.

