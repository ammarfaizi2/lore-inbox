Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932742AbWEXNc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742AbWEXNc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWEXNc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:32:29 -0400
Received: from [195.23.16.24] ([195.23.16.24]:54468 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932742AbWEXNc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:32:28 -0400
Message-ID: <4474605B.70007@grupopie.com>
Date: Wed, 24 May 2006 14:32:11 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "D. Hazelton" <dhazelton@enter.net>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <E1Fifom-0003qk-00@chiark.greenend.org.uk>	 <9e4733910605231638t4da71284oa37b66a88c60cf8a@mail.gmail.com>	 <200605232324.20876.dhazelton@enter.net> <9e4733910605232121s259e97fdu755e1f2762026e5f@mail.gmail.com>
In-Reply-To: <9e4733910605232121s259e97fdu755e1f2762026e5f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> [...]
> BenH has source for a working emu86. I would wait on that project
> until klibc has been merged.

A while ago I worked on cleaning up the emulator that was first written 
by SciTech, and then used by X and LinuxBIOS people.

The .text size of the emulator went from 59478 to 38225 bytes, but I bet 
I could shrink it even further. The emulator was a bit optimized for 
speed, but IMHO we want it optimized for size.

If I can get the emulator to use, say, 20kB, wouldn't it be better to 
have it in the kernel instead of as user-space helper?

This would allow the graphics driver to call BIOS functions as if they 
were regular functions, i.e., you could call on a BIOS function to set 
the graphics mode and continue execution when the BIOS function completes.

A user mode helper will always be more cumbersome from a programming 
POV. Not to mention that it would be a lot easier for distro maintainers...

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
