Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318752AbSH1HrX>; Wed, 28 Aug 2002 03:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318757AbSH1HrX>; Wed, 28 Aug 2002 03:47:23 -0400
Received: from smtp3.cern.ch ([137.138.131.164]:2483 "EHLO smtp3.cern.ch")
	by vger.kernel.org with ESMTP id <S318752AbSH1HrW>;
	Wed, 28 Aug 2002 03:47:22 -0400
Date: Wed, 28 Aug 2002 09:51:35 +0200 (CEST)
From: Federico Carminati <Federico.Carminati@cern.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: pcmcia support (fwd)
Message-ID: <Pine.LNX.4.21.0208280925370.15627-100000@lxplus009.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  trying to follow this thread. I am an absolute beginner. I bought a
laptop clone, PIV 2.4GHz and installed 7.3RH. The sound does not work and
I have the impression that this is because the sound system and the modem
share an IRQ (9?), which I have the impression is not supported by Linux,
while it works with windows. From the message below you can see that I was
suggested to write to the linux kernel list which I am doing now. The
chipset is VIA VT8233. I installed the OSS sound system, and it works
erratically. Any help would be appreciated. Thanks in advance. Fed


                                            Federico Carminati

==============================================================================
|| Federico Carminati             ||  Tel.: +41.22.767.4959                 ||
|| CERN-EP                        ||  Fax.: +41.22.767.9480                 ||
|| 1211 Geneva 23                 ||                                        ||
|| Switzerland                    ||                                        ||
==============================================================================

---------- Forwarded message ----------
Date: Wed, 7 Aug 2002 22:29:04 -0700
From: dhinds <dhinds@sonic.net>
To: Federico Carminati <federico.carminati@cern.ch>
Subject: Re: pcmcia support

On Thu, Aug 01, 2002 at 11:50:53PM +0200, Federico Carminati wrote:
> The laptop has no brand, as it is an assembled clone. The yenta messages are 
> there:
> 
> 
> Aug  1 00:36:27 localhost kernel: Yenta IRQ list 00b8, PCI irq0
> Aug  1 00:36:27 localhost kernel: Socket status: 30000410
> Aug  1 00:36:27 localhost kernel: Yenta IRQ list 02b8, PCI irq0
> Aug  1 00:36:27 localhost kernel: Socket status: 30000006
> 
> Trying to install sound i discovered that some IRQ's are shared, which does 
> not help. Thanks, Fed

I'm afraid the problem is in the PCI subsystem and I have no other
workaround if pci=biosirq does not help.  The yenta driver relies on
the PCI subsystem to find the interrupt assignment for the cardbus
bridge device, and doesn't work properly if the interrupt can't be
determined.

You can try reporting the bug to the PCI subsystem maintainer or to
the linux-kernel mailing list.  I don't know enough about PCI to try
to track it down.

-- Dave

