Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUKHSzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUKHSzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUKHSyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:54:45 -0500
Received: from mail2.epfl.ch ([128.178.50.133]:4625 "HELO mail2.epfl.ch")
	by vger.kernel.org with SMTP id S261194AbUKHSwv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:52:51 -0500
Date: Mon, 8 Nov 2004 19:52:49 +0100
From: Gregoire Favre <Gregoire.Favre@freesurf.ch>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Grzegorz Kulewski <kangur@polcom.net>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
Message-ID: <20041108185249.GK5360@magma.epfl.ch>
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch> <418EB8EB.30405@kolivas.org> <20041108003323.GE5360@magma.epfl.ch> <418EBFE5.5080903@kolivas.org> <Pine.LNX.4.60.0411080919220.32677@alpha.polcom.net> <87bre88zt8.fsf@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87bre88zt8.fsf@bytesex.org>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 10:17:39AM +0100, Gerd Knorr wrote:

> Well, if it happens almost independant of the kernel/driver version it
> most likely is buggy hardware.  I can't do much about it ...

? Why couldn't it be a bug present in all kernels/drivers ?
Under bugs.gentoo.org there are quiete a lots of those, for example
http://bugs.gentoo.org/show_bug.cgi?id=64728 and google can show a lots
more.

> Well known example are some via chipsets which have trouble with
> multiple devices doing DMA at the same time (those tend to run stable
> with bttv once you've turned off ide-dma ...).

I had those xawtv crash with an SCSI only system, and on all my
MB/CPU/RAM test I doubt that all hardware configuration were buggy.

> Getting broken hardware run stable and fast is black magic.  You can
> try these (if that happens to help we can put that info into the pci
> quirks btw.):
> 
>   eskarina kraxel ~# modinfo bttv | grep "pci config"
>   parm: vsfx:set VSFX pci config bit [yet another chipset flaw workaround]
>   parm: triton1:set ETBF pci config bit [enable bug compatibility for triton1 + others]
> 
> Otherwise BIOS updates, obscure BIOS settings, shuffling cards in PCI
> slots, enable/disable ACPI and/or APIC, whatelse may or may not help.
> 
> See also Documentation/video4linux/bttv/README.freeze

I only have DVB hardware, is that also considered as bttv ?
I have tried a lots of different configuration, with or without fb,
playing in the BIOS, pre-empt/no, ACPI/noACPI ... no change at all.

Some things I have noticed : xawtv and kdetv don't need CPU to achieve
the best quality I know about BUT they make the system crash.
kvdr and tvtime needs lots of time and there quality are really lower
than the two others, BUT they don't crash my system.

I can't speak about xawdecode because I am not able to run it under
amd64... neither zapping.

What I do now is to stop xawtv before doing a large copy of files...

I would happily try any suggestion :-)

Thank you very much,
-- 
	Grégoire Favre
________________________________________________________________________
http://magma.epfl.ch/greg ICQ:16624071 mailto:Gregoire.Favre@freesurf.ch
