Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUHVOXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUHVOXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUHVOXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:23:46 -0400
Received: from colin2.muc.de ([193.149.48.15]:35079 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267250AbUHVOXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:23:45 -0400
Date: 22 Aug 2004 16:23:44 +0200
Date: Sun, 22 Aug 2004 16:23:44 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, eich@suse.de
Subject: Re: [patch] context-switching overhead in X, ioport(), 2.6.8.1
Message-ID: <20040822142344.GA81458@muc.de>
References: <2vEzI-Vw-17@gated-at.bofh.it> <m3n00nwepr.fsf@averell.firstfloor.org> <1093176046.24272.68.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093176046.24272.68.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Xorg and XFree assume the kernel will have intelligent limits. When the
> range went up the EnableIO code in turn switched to ioperm.

Which was the wrong thing to do since it is slower.

> 
> The actual code is:
> 
>        if (ioperm(0, 1024, 1) || iopl(3))
>                 FatalError("xf86EnableIOPorts: Failed to set IOPL for
> I/O\n")
> 
> (os-support/linux/lnx_video.c:xf86EnableIO)
> 
> Flip those around and rebuild.

It would be better to do that in the official release.

-Andi
