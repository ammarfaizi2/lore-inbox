Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVEYPOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVEYPOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVEYPOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:14:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40906 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262362AbVEYPOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:14:11 -0400
Date: Wed, 25 May 2005 17:13:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Prakash Punnoor <lists@punnoor.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp and kernel 2.6.12-rc4 does not work
Message-ID: <20050525151353.GC4375@elf.ucw.cz>
References: <429353F8.5070404@punnoor.de> <20050525130123.GA1881@elf.ucw.cz> <42949431.7000006@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42949431.7000006@punnoor.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I haven't treid with an earlier kernel. I am using an Sony Vaio PCG-F8ß07K
> >>notebook and tried to suspend.
> >>
> >>What goes wrong is, that the hd gets shut down before anything is written to it.
> >>
> >>I see (leaving some details out):
> >>
> >>Stopping task:========================|
> >>Freeing memory..done (40502 pages freed)
> >>swsusp: Need to copy 6953 pages
> >>swsusp: critical section/: done (6981 pages copied)
> >>ACPI: PCI Interrupt yadda yadda.. -> IRQ 9
> >>
> >>and there it sits. Is it really just the problem, that the hd gets shut down
> >>too early? Is there an easy way to fix this?
> > 
> > 
> > Disk shutdown is normal, you have other problem. Try again with
> > minimal drivers.
> 
> But shouldn't this happen, *after* memory image is written into swap?
> Otherwiese disk shuts down, spins up, writes image, shuts down, which is not
> too healthy for the hd.

No, it is not too healthy for the hd, and I'll fix it for 2.6.13, but
you'll have to live with it for 2.6.12. See FAQ why.

> I'll try with minimal drivers anyway.

..will not fix disk going down up down, but could fix your other
problem...

								Pavel
