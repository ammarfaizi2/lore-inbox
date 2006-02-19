Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWBSUwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWBSUwD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 15:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBSUwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 15:52:03 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:8589 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932192AbWBSUwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 15:52:01 -0500
Date: Sun, 19 Feb 2006 12:51:57 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Nick Warne <nick@linicks.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Pavel Machek <pavel@suse.cz>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060219205157.GA5976@us.ibm.com>
References: <20060218231419.GA3219@elf.ucw.cz> <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com> <7c3341450602190318o1c60e9b5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3341450602190318o1c60e9b5w@mail.gmail.com>
X-Operating-System: Linux 2.6.16-rc3-git3 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.02.2006 [11:18:04 +0000], Nick Warne wrote:
> There is definately something going on with these cards.
> 
> Ref. my LKML thread here:
> 
> http://lkml.org/lkml/2006/2/11/25
> 
> My card as reported in dmesg:
> 
> PCI: Found IRQ 12 for device 0000:00:0f.0
> ALSA device list:
>   #0: SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xe000, irq 12

I also have a SBLive 5.1 card, seems to be the same rev/serial and I
have no problems using it (I haven't check any of the non-speaker ports,
though).

[   55.007817] Advanced Linux Sound Architecture Driver Version 1.0.11rc2 (Wed Jan 04 08:57:20 2006 UTC).
[   55.022668] ALSA device list:
[   55.022672]   #0: SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xac00, irq 209

> lspci:
> 
> 00:0f.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
> 00:0f.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

0000:01:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:01:06.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)

/proc/asound/cards:


 0 [Live           ]: EMU10K1 - SBLive 5.1 [SB0060]
                      SBLive 5.1 [SB0060] (rev.7, serial:0x80611102) at 0xac00, irq 209

> Now, I built and installed latest:
> 
> alsa-utils-1.0.11rc2
> alsa-lib-1.0.11rc3

I run Ubuntu Breezy, which has:

alsa-utils = 1.0.9a-4ubuntu5

This is all from 2.6.16-rc4, btw.

Thanks,
Nish
