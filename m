Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284899AbRLKHC0>; Tue, 11 Dec 2001 02:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284913AbRLKHCQ>; Tue, 11 Dec 2001 02:02:16 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:25611 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S284899AbRLKHCC>; Tue, 11 Dec 2001 02:02:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        belg4mit@dirty-bastard.pthbb.org (Jerrad Pierce)
Subject: Re: 2.4.14/16 load reboots
Date: Tue, 11 Dec 2001 02:01:09 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16CoNe-0002bu-00@the-village.bc.nu>
In-Reply-To: <E16CoNe-0002bu-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16DguO-0004GD-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 December 2001 15:47, Alan Cox wrote:

> There are a set of old machines that do this sort of stuff with all 2.4.x
> kernels. Right now I don't know why. The Digital celebris has the same
> bug.

Well it's nice to see I'm not alone in this. I gave up on my SuperMicro
Micro ATX 370 boards a few weeks ago. They were used primarily with WinNT so 
they don't have a well  establishied Linux track record. (Though one of them 
did run a mid 2.2.?? for a short time, and I didn't notice any issues
with it.)

I'd like to use them as routers, but they die with heavy network activity. 
>From my experience it looks like an IRQ problem, but no amount of BIOS 
fiddling will get them stable.

My findings after playing around with them tonight

	2.4.10 or 2.4.16 seems maybe a bit then 2.4.8
	With a 'default' config it may take a few minutes of ping -f and
	scp, it bring it down, but it will die suddenly rebooting.

	The primary board I'm using is a D-Link Quad Tulip. By 'default' it
	scans the eth's in reverse. pci=nosort fixes that. Something strange
	is eth2 alwasy picks up irq 5, while the rest are 11 (it
	always shifts to the logical eth2 depending on the sort)

	Playing with various pci= options will get it so it dies instantly
	from `ping -f`. pci=biosirq seems to be a sure bet.

	> Turn both of these off
	> And these
	Didn't help. In fact it dies instantly with `ping -f`

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
