Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVCDLVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVCDLVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 06:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbVCDLRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 06:17:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62613 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262881AbVCDLPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 06:15:33 -0500
Date: Fri, 4 Mar 2005 12:15:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mjg59@scrf.ucam.org, hare@suse.de
Subject: Re: swsusp: allow resume from initramfs
Message-ID: <20050304111518.GM1345@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz> <20050304030410.3bc5d4dc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050304030410.3bc5d4dc.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 04-03-05 03:04:10, Andrew Morton wrote:
> Pavel Machek <pavel@suse.cz> wrote:
> >
> > When using a fully modularized kernel it is necessary to activate
> >  resume manually as the device node might not be available during
> >  kernel init.
> 
> I don't understand how this can be affected by the modularness of the
> kernel.  Can you explain a little more?
> 
> Would it not be simpler to just add "resume=03:02" to the boot
> command line?

Problem is if 03:02 is IDE module, and you don't have it built into
kernel. Then you want to insmod it from initramfs, and only then
activate resume.

For some reasons (probably good ones) distributions insists on having
everything as modules. At least SuSE and Debian want this... It also
allows stuff like graphically asking "you booted wrong kernel, do you
want me to wipe the signature, or will you reboot the correct kernel",
because you can do it userspace in initrd before actually calling
resume.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
