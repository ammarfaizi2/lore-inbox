Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265317AbUF2AIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265317AbUF2AIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 20:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUF2AIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 20:08:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1481 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265317AbUF2AGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 20:06:33 -0400
Subject: Re: io apic + tsc = slowdown (bugreport + possible fix)
From: john stultz <johnstul@us.ibm.com>
To: Frederic Krueger <spamalltheway@bigfoot.com>, macro@ds2.pg.gda.pl
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <40DFC853.20803@bigfoot.com>
References: <40DFC853.20803@bigfoot.com>
Content-Type: text/plain
Message-Id: <1088467569.1944.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 28 Jun 2004 17:06:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-06-28 at 00:27, Frederic Krueger wrote:
> just wanted to point out the patch I imported from an older version of 
> the 2.6.x kernel (not done by me at all ;-)).
> It's basically causing the system to a near zero slowdown after one hour 
> of uptime. And the reason for it must be the io_apic irq0 handling with 
> TSC enabled systems (seems to show up on ibm pre-built boxes more often 
> than on others though).
> Funnily pressing any keys _all the time_ works around for this for the 
> time a key is pressed ;)

I duped the bug to 2544. I've got the BIOS folks looking at this issue
on the x305 for the proper fix. 

Looking closer at the proposed workaround by Maciej posted here:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/3174.html

Why exactly are we using cpu_has_tsc to switch this? I'm not sure I'm
following how this is TSC dependent. Additionally the comment change
looks to be from the 2.4 era. 

Maciej, could you further explain? 

thanks
-john


