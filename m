Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbUAIXMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 18:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUAIXMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 18:12:25 -0500
Received: from user-119ahgg.biz.mindspring.com ([66.149.70.16]:17636 "EHLO
	mail.home") by vger.kernel.org with ESMTP id S264494AbUAIXMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 18:12:23 -0500
From: Eric <eric@cisu.net>
To: lkml@nitwit.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6: The hardware reports a non fatal, correctable incident occured on CPU 0.
Date: Fri, 9 Jan 2004 17:12:02 -0600
User-Agent: KMail/1.5.94
References: <200401091748.10859.lkml@nitwit.de>
In-Reply-To: <200401091748.10859.lkml@nitwit.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200401091712.02802.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 10:48 am, lkml@nitwit.de wrote:
> Hi!
>
> I did have some very scary issues today playing with 2.6. The system was
> booted and ran several times today, the longtest uptime was approximately
> about an hour.
>
> But then shortly after having booted 2.6 I got syslog messages:
>
> The hardware reports a non fatal, correctable incident occured on CPU 0.
>
> I shut down the machine. After this my Athlon XP 2200+ showed up as 1050MHz
> in BIOS an indeed the bus frequency was set to 100 instead of 133 MHz (how
> can an OS change the BIOS?!) - nevertheless the CPU should have shown up as
> 1500MHz. I set it back to 133 MHz - which resulted in the machine did not
> even reach the BIOS no more but was rebooting automatically prior to it. I
> turned off the machine for some seconds - no change. I turned it off for a
> few minutes and the BIOS showed up again - with 1050MHz. So I had to set
> the freq back to 133 MHz a second time. I booted my 2.4.21 kernel which
> seems to run.
	Check your hardware CPU/MOBO/RAM. Overheating? Bad Ram? Cheap mobo?
MCE should not be triggered under any circumstances unless it is a kernel 
bug(RARE, I believe the MCE code is simple) or you REALLY have a hardware 
problem. As said before, the bios is resetting your fsb to 100 as a fail-safe 
because something bad happened.
	BTW, check your setup, an AMD 2200+ should run at 1.8ghz i believe. If you 
are setting your FSB or multiplier too low, that might also be triggering a 
problem. A quick google lists amd xp2200+ as 1800mhz

> What the fuck is going on here?? As far as I figured out this has something
> to do with MCE (CONFIG_X86_MCE=y, CONFIG_X86_MCE_NONFATAL=y) (?).
	Leave it enabled, its a good thing to tell you when you have bad hardware. 
Its not a kernel problem, but a feature.
-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
