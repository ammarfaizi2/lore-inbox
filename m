Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268742AbUHTUhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268742AbUHTUhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUHTUfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:35:44 -0400
Received: from sccimhc91.asp.att.net ([63.240.76.165]:26258 "EHLO
	sccimhc91.asp.att.net") by vger.kernel.org with ESMTP
	id S264973AbUHTUck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:32:40 -0400
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Audio volume poor in Linux, OK in Win2K
Date: Fri, 20 Aug 2004 15:32:41 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201532.41296.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get much volume out of my audio controller.

I have a dual-boot system, Win2K/SP4 and Fedora Core 2 (FC2), both with 
all updates applied.  The volume is fine in Win2K.  In FC2, even with the 
volume turned up to 100%, audio output is barely loud enough for voices 
to be understood.  This is true whether using the built-in speakers or 
with headphones.  The lack of volume is *not* application dependant.

Prior to installing FC2, I ran RedHat Linux v9 with the most recent 2.4.x 
kernel available at that time.  The audio volume was also inadaquate in 
this environment, yet was still fine in Win2K.

I see no errors or warning in my system logs that might indicate any 
problems with the audio driver in use.

My hardware is a HP Presario 2570us notebook, which has an integrated ALi 
M5451 audio controller.  More detail:

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 0850
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 1000
        Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2

These are the audio-related (kernel v2.6.8) modules seen with lsmod:

 snd_ali5451            18888  0
 snd_ac97_codec         58500  1 snd_ali5451
 snd_pcm                75912  1 snd_ali5451
 snd_page_alloc          8584  1 snd_pcm
 snd_timer              18692  1 snd_pcm
 snd                    42596  4   
snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
 soundcore               6624  1 snd

It seems that the Linux audio subsystem is incapable of producing the 
audio volume that I get in Win2K, at least with this hardware.  Is there 
anything I can do to get more volume in Linux?

Thanks.

