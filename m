Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbVJZUZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbVJZUZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVJZUZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:25:19 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:23300 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S964891AbVJZUZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:25:17 -0400
Date: Wed, 26 Oct 2005 20:35:56 +0100
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
Message-ID: <4DC00ACF03%linux@youmustbejoking.demon.co.uk>
In-Reply-To: <871x28k2n0.fsf@obelix.mork.no>
User-Agent: Messenger-Pro/3.30b1 (MsgServe/3.10) (RISC-OS/4.02) POPstar/2.06+cvs
To: linux-kernel@vger.kernel.org
Cc: bmork@dod.no
Mail-Followup-To: linux-kernel@vger.kernel.org,bmork@dod.no,linux@youmustbejoking.demon.co.uk
Subject: Re: Call for PIIX4 chipset testers
X-Editor: Zap 1.47 (17 Oct 2005) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Wed, 4439 Sep 1993 20:35:56 +0100
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Note: not subscribed. Message should have been Cc'd. M-F-T set.]

I demand that Bjørn_Mork may or may not have written...

> Darren Salt <linux@youmustbejoking.demon.co.uk> writes:
>>   $ dmesg | grep PIIX4
[irrelevant details snipped]
>>   PIIX4 devres C PIO at 0100-0107
>>   PIIX4 devres I PIO at 00e0-00e3
>>   PIIX4 devres J PIO at 00f9-00fc

>> Machine is a Compaq Armada M700; [...]

> Interesting. The second device here is probably a SMC FDC37N971? I remember
> there used to be some hacks around because it was relocated from the
> default 0x3f0 or 0x370 to 0xe0.  This affected the smc-ircc driver among
> other things.

It is, it is at 0x0E0, and it does, although the following is needed for that
driver (which I have built as a module):

  # setserial /dev/ttyS2 irq 3 uart none; modprobe smsc-ircc2

> See for example http://www.lrr.in.tum.de/~acher/m300/

Hmm... I've seen that page before - the backlight control program which is
available there works on my M700. (I don't remember what I was looking for at
the time; probably something to do with the graphics hardware and why atyfb
makes a complete mess of the display. Yes, it's a Rage Mobility, 1002:4c4d;
yes, I can test patches.)

[snip]
> Unfortunately both of the M300s I have around here are now stone dead,
> so I can't test the patch.

I suspect that there's a *lot* of similarity...

-- 
| Darren Salt | nr. Ashington, | d youmustbejoking,demon,co,uk
| Debian,     | Northumberland | s zap,tartarus,org
| RISC OS     | Toon Army      | @
|   Retrocomputing: a PC card in a Risc PC

Never, ever use repetitive redundancies.
