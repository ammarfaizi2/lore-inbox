Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTDPPIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTDPPIc 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:08:32 -0400
Received: from air-2.osdl.org ([65.172.181.6]:15566 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264457AbTDPPI0 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:08:26 -0400
Date: Wed, 16 Apr 2003 08:18:59 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Udo Hoerhold <maillists@goodontoast.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SoundBlaster Live! with kernel 2.5.x
Message-Id: <20030416081859.5a2f37af.rddunlap@osdl.org>
In-Reply-To: <200304160200.57995.maillists@goodontoast.com>
References: <200304152001.35975.maillists@goodontoast.com>
	<200304160034.11567.maillists@goodontoast.com>
	<32822.4.64.197.106.1050469134.squirrel@webmail.osdl.org>
	<200304160200.57995.maillists@goodontoast.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003 02:00:57 -0400 Udo Hoerhold <maillists@goodontoast.com> wrote:

| On Wednesday 16 April 2003 12:58 am, Randy.Dunlap wrote:

| > >
| > > I have the exact configuration you have above.  The soundcard is
| > > detected, but I do get one error:
| > >
| > > Apr 15 22:17:45 hobbiton kernel: Advanced Linux Sound Architecture Driver
| > > Version 0.9.2 (Thu Mar 20$
| > > Apr 15 22:17:45 hobbiton kernel: request_module: failed /sbin/modprobe --
| > > snd-card-0. error = -16
| > > Apr 15 22:17:45 hobbiton kernel: PCI: Found IRQ 10 for device 02:0b.0 Apr
| > > 15 22:17:45 hobbiton kernel: PCI: Sharing IRQ 10 with 00:1f.2
| > > Apr 15 22:17:45 hobbiton kernel: ALSA device list:
| > > Apr 15 22:17:45 hobbiton kernel:   #0: Sound Blaster Live! (rev.7) at
| > > 0xdf80, irq 10
| > >
| > > I've been ignoring modprobe errors because I know there are some issues
| > > with 2.5 kernel and modules, and I'm compiling everything into the
| > > kernel.  Could this be causing a problem, though?
| >
| > I don't think you need to be ignoring module problems now.
| >
| > Do you have emu10k1 built as loadable module or in-kernel?
| >
| > -16 error is saying that the IO region or the IRQ is busy so the
| > driver can't allocate it.
| >
| > Is /sbin/modprobe a current version (for 2.5.50++ and recent)?
| >
| > ~Randy
| 
| It's compiled into the kernel.  I'm not sure why I would be getting modprobe 
| errors, everything is compiled in.  I have module-init-tools 0.9.11a, which 
| is the right modprobe for 2.5.46 and up, right?

That sounds right for tools.
But if emu10k1 is built into the kernel, you don't need to modprobe it at all.
Why is that happening?  Do you actually have emu10k1 module also?
It should have errors when loading if the device is already claimed.


--
~Randy
