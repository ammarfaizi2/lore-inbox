Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVAaHMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVAaHMZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVAaHMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:12:25 -0500
Received: from gate.crashing.org ([63.228.1.57]:49053 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261688AbVAaHMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:12:19 -0500
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050129163117.1626d404.akpm@osdl.org>
References: <20050129163117.1626d404.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 18:11:50 +1100
Message-Id: <1107155510.5905.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 16:31 -0800, Andrew Morton wrote:
> help!
> 
> Begin forwarded message:
> 
> Date: Sat, 29 Jan 2005 23:56:23 +0000
> From: Sean Neakums <sneakums@zork.net>
> To: Andrew Morton <akpm@osdl.org>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.6.11-rc2-mm2
> 
> 
> Sean Neakums <sneakums@zork.net> writes:
> 
> > On a PowerBook (PowerBook5.4), when snd_powermac is modprobed during
> > the boot, I get the following.  After similar messages for a few more
> > modules, the machine seems wedged.
> 
> Brice Goglin's patch fixes this.
> 
> However, when I modprobe radeonfb I get:
> 
> Jan 29 23:38:16 briny kernel: PCI: Unable to reserve mem region #1:8000000@b8000000 for device 0000:00:10.0
> Jan 29 23:38:16 briny kernel: radeonfb: probe of 0000:00:10.0 failed with error -16
> 
> Not sure if this is expected or not on this platform.
> 
> With radeonfb built-in (my current working configuration with 2.6.9)
> the screen clears and the machine seems to hang early in the boot.

So, I did more tests. As I wrote previously, it's normal that radeonfb
as a module doesn't work when offb is in the kernel, we don't quite have
an infrastructure to deal with driver "replacement" yet.

It seems -mm2 definitely has some problems regarding loading of modules,
it pretty much fails loading all of them for me with some
kobject_register errors, I haven't really found out what was up, but
then, I didn't have much time neither.

radeonfb built-in operations seem to be ok on my PowerBook3,5 (ATI M9
based), I'll try on a PowerBook5,4 (same as yours) tomorrow hopefully.

Does the machine hang with the screen completely cleared ? Do you see
the penguin logo ? Did you try just using pmac_defconfig ?

Ben.


