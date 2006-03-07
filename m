Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWCGTJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWCGTJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWCGTJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:09:24 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:64641 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1750940AbWCGTJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:09:23 -0500
Message-ID: <440DDA46.2010503@hispeed.ch>
Date: Tue, 07 Mar 2006 20:08:54 +0100
From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
References: <440C5672.7000009@cern.ch>	<200603061656.18846.duncan.sands@math.u-psud.fr> <440D7384.5030307@cern.ch>
In-Reply-To: <440D7384.5030307@cern.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-07.tornado.cablecom.ch 32701;
	Body=2 Fuz1=2 Fuz2=2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Tyr wrote:
> Michel Bardiaux wrote:
> 
>  >I dont see anything suspicious conflict. But 'overlay' has been
>  >mentionned, I'm not familiar with that but I assume it means you're
>  >doing video grabs directly to the X display, right?
> 
> Yes, I'm using xawtv + overlay directly to the X display :0.0. Is better 
> way to use it with some WM (KDE, Gnome, ...)?
> 
>  >Then it could be a problem with the graphics card or its driver.
> 
> On the mainboard is graphics card Intel 915. I have tryed it with i810 
> (with / without DRI) and vesa driver. I have also tryed PCIE graphics 
> card from ATI. In all of those cases the PC freeze and as well as if is 
> in PCI slot only ONE tuner!
> 
>  >Just my 2 cents, because I am totally unfamiliar with such uses, sounds
>  >like a problem for the MythTV crowd.
> 
> I'm totally lost! I have here 25 PCs (100 tuners) what always freeze ;o(
FWIW, I have a box (with only one bttv card) which does not work stable 
neither due to the capture card. It DID run stable at one point, but I 
think that was kernel 2.2-ish... I tried quite a few things, IIRC when 
it did run stable I had to tweak pci latency timer in the bios, but this 
no longer works. Tried kernels with/without apic, acpi, smp,...
I also get the same OCERR error messages, and very similar oops. Though 
it usually locks up only once every few hours or even days. Sometimes 
hard and sometimes soft lockups.
The bttv driver/chip seems to cause random memory corruption sometimes, 
processes will just start dying... My guess is that somehow dma 
transfers to random / wrong addresses happens when there are lost irqs / 
pci bus contention, either due to a driver bug or a chip bug (something 
like losing parts of the risc program) though if there is a chip bug, 
that behaviour never happened with some other OS so a workaround should 
be possible), but I could be ways off.
This was with a i440bx chipset btw, it runs just fine with a newer box 
(though overlay had problems there too, but since the box is faster I'm 
just using grabdisplay, which didn't do anything for stability on the 
old box). Tried both a bt848 and bt878 card which didn't change anything.

Roland

