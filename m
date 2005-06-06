Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVFFOph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVFFOph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 10:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVFFOph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 10:45:37 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10916 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261484AbVFFOpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 10:45:21 -0400
Date: Mon, 6 Jun 2005 16:45:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM)
Message-ID: <20050606144501.GB2243@elf.ucw.cz>
References: <200506051456.44810.hugelmopf@web.de> <1117978635.6648.136.camel@tyrosine> <200506051732.08854.stefandoesinger@gmx.at> <1118053578.6648.142.camel@tyrosine> <1118056003.6648.148.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118056003.6648.148.camel@tyrosine>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I've no idea how to debug a reboot, but if the system hangs it's possible to 
> > > add "lcall $0xffff,$0" early in the wakeup assembler code. If the system 
> > > reboots immediatly then, the kernels wakeup code was reached and the kernel 
> > > hangs later during resume.
> > 
> > Ok, I've just tried that. The system still just freezes.
> 
> Whoops. May have been a bit too hasty there. I'm not sure why that
> doesn't reset it, but we've now got the following (really rather odd)
> serial output. Does anyone have any idea what might be triggering this?
> Shell builtins work fine, but anything else seems to explode very
> messily. Memory corruption of some description?
> 
> ^MRestarting tasks... done
> ^Mroot@(none):/# ^M
> root@(none):/# ls -la ^M
> Unable to handle kernel NULL pointer dereference at virtual address
> > > 00000024

NULL pointer dereference in filp_open; whats that strange about it?
Use printks to debug this one, nothing mysterious.
								Pavel

