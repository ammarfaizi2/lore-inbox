Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRKHRPD>; Thu, 8 Nov 2001 12:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRKHROy>; Thu, 8 Nov 2001 12:14:54 -0500
Received: from zero.tech9.net ([209.61.188.187]:47120 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S276709AbRKHROl>;
	Thu, 8 Nov 2001 12:14:41 -0500
Subject: Re: AMD761Agpgart+Radeon64DDR+kernel+2.4.14...no go...
From: Robert Love <rml@tech9.net>
To: Cyrus <cyjamten@ihug.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEA7525.7070807@ihug.com.au>
In-Reply-To: <20011108113615.F27652@suse.de>
	<Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain>
	<20011108123808.I27652@suse.de>  <3BEA7525.7070807@ihug.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 08 Nov 2001 12:14:52 -0500
Message-Id: <1005239692.939.34.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-08 at 07:05, Cyrus wrote:
> i've been having problems with starting my xserver all the time... my 
> monitor tells me that i have no connection at all after starting X... 
> complete system failure... no sysrq keys and stuff.. this is my fifth to 
> seventh install of slackware 8 in approximately 3 weeks... errors in 
> filesystems and reiserfs couldn't handle the crashing anymore and tells 
> me i couldn't mount my root filesystem (superblock errors, etc.)...
> 
> anyway, i'm just curious if this is about the radeon drivers or the amd 
> 761 agpgart that Robert Love had made.. with all due respect to Robert 
> he did a good job... my amd chipset wasn't even recognized before this 
> patch-turned main stream kernel supported hardware...(but is it really 
> supported?). my friend is also experiencing the same problems and he has 
> the amd 751 chipset and the radeon combo as well... i've tried quite a 
> lot of things just to make my machine perform like a real linux box 
> should be but to no avail... X keeps me down as in crashes 7 out of 8 
> times i start X... i've read and researched on this issue for months and 
> i'm still one of the guys who hasn't found the answer...

I doubt its the AMD 761 AGPGART driver.  It is easy to see if it is:
don't load the AMD 761 driver.  I think the DRI component of the ATI
driver is all that uses AGPGART, so unload that too.

Thus, see if just the Radeon with no DRI and no AGPGART is a problem.

	Robert Love

