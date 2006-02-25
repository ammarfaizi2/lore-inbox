Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWBYCMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWBYCMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 21:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWBYCMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 21:12:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61876 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964857AbWBYCMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 21:12:30 -0500
Date: Fri, 24 Feb 2006 18:11:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: My machine is cursed: no sound. Help! [was Re: es1371 sound
 problems]
Message-Id: <20060224181137.52d6da79.akpm@osdl.org>
In-Reply-To: <20060224234050.GA1644@elf.ucw.cz>
References: <20060223205309.GA2045@elf.ucw.cz>
	<s5h1wxtdmri.wl%tiwai@suse.de>
	<20060224161631.GB1925@elf.ucw.cz>
	<20060224234050.GA1644@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Hi!
> 
> > > I've seen similar messages in some reports but haven't figured out the
> > > cause yet.
> > > 
> > > To be sure, could you check the patch below, making the wait time in
> > > codec acceessor longer?
> > > Also, try to build ens1371 driver as a module.
> > 
> > Tried that... only msleep() hunks did apply, but that should be only
> > more conservative, AFAICT. It took looong time to boot (my fault,
> > should have used 50, not 0xa000 or how much is that), but same result
> > as before. I tried loading it as a module, but same problem :-(.
> 
> I guess my machine is cursed. emu10k does not work -- produces no
> sound. ens1371 does not work -- is not initialized. usb sound card --
> produces no sound.
> 
> Now, I tried to break the curse by connecting usb sound card to
> another machine... but guess what, still no sound. Connected to second
> machine:
> 
> root@amd:~# cat /proc/asound/cards
>  0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
>                       Intel 82801DB-ICH4 with AD1981B at 0xc0000c00, irq 5
>  1 [U0x4fa0x4201   ]: USB-Audio - USB Device 0x4fa:0x4201
>                       USB Device 0x4fa:0x4201 at usb-0000:00:1d.1-2, full speed
> root@amd:~#
> 
> (usb soundcard clicks when I launch mpg123, but that's it.)
> 
> Any ideas?

Maybe you went deaf?


Are any of the above regressions, or has it always been like that?
