Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268839AbUHUDnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268839AbUHUDnZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 23:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268840AbUHUDnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 23:43:25 -0400
Received: from main.gmane.org ([80.91.224.249]:12425 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268839AbUHUDnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 23:43:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Audio volume poor in Linux, OK in Win2K
Date: Sat, 21 Aug 2004 12:43:17 +0900
Message-ID: <cg6gcm$52r$1@sea.gmane.org>
References: <200408201532.41296.swsnyder@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <200408201532.41296.swsnyder@insightbb.com>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Snyder wrote:
> I can't seem to get much volume out of my audio controller.
> 
> I have a dual-boot system, Win2K/SP4 and Fedora Core 2 (FC2), both with 
> all updates applied.  The volume is fine in Win2K.  In FC2, even with the 
> volume turned up to 100%, audio output is barely loud enough for voices 
> to be understood.  This is true whether using the built-in speakers or 
> with headphones.  The lack of volume is *not* application dependant.
> 
> Prior to installing FC2, I ran RedHat Linux v9 with the most recent 2.4.x 
> kernel available at that time.  The audio volume was also inadaquate in 
> this environment, yet was still fine in Win2K.
> 
> I see no errors or warning in my system logs that might indicate any 
> problems with the audio driver in use.
> 
> My hardware is a HP Presario 2570us notebook, which has an integrated ALi 
> M5451 audio controller.  More detail:
> 
> 00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
> Controller Audio Device (rev 02)
>         Subsystem: Hewlett-Packard Company: Unknown device 0850
>         Flags: bus master, medium devsel, latency 64, IRQ 5
>         I/O ports at 1000
>         Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [dc] Power Management version 2
> 
> These are the audio-related (kernel v2.6.8) modules seen with lsmod:
> 
>  snd_ali5451            18888  0
>  snd_ac97_codec         58500  1 snd_ali5451
>  snd_pcm                75912  1 snd_ali5451
>  snd_page_alloc          8584  1 snd_pcm
>  snd_timer              18692  1 snd_pcm
>  snd                    42596  4   
> snd_ali5451,snd_ac97_codec,snd_pcm,snd_timer
>  soundcore               6624  1 snd
> 
> It seems that the Linux audio subsystem is incapable of producing the 
> audio volume that I get in Win2K, at least with this hardware.  Is there 
> anything I can do to get more volume in Linux?

Yes, play with alsamixer and bump everything to 100% (and unmute it).
Mainly I guess you forgot the PCM control.
Some devicecs have "External Amplifier" switch, try that too.

If you are still with problems, please do:

$ alsactl -f current.conf store

and attach current.conf

Kalin.

-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

