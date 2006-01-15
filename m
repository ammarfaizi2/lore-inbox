Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWAOX3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWAOX3R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 18:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbWAOX3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 18:29:17 -0500
Received: from smtpout.mac.com ([17.250.248.86]:16113 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750985AbWAOX3Q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 18:29:16 -0500
In-Reply-To: <200601151526.34236.rene@exactcode.de>
References: <200601151051.14827.rene@exactcode.de> <200601151312.42391.rene@exactcode.de> <20060115123133.GB15881@mars.ravnborg.org> <200601151526.34236.rene@exactcode.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <AF73D553-56EC-4EAE-BF1F-4ACF1E5CFFC3@mac.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>, akpm@osdl.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: kbuild / KERNELRELEASE not rebuild correctly anymore
Date: Sun, 15 Jan 2006 18:29:00 -0500
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 15, 2006, at 09:26, René Rebe wrote:
> Hi,
>
> On Sunday 15 January 2006 13:31, Sam Ravnborg wrote:
>>> I'm curious, aside rsbac, what in the .config is altering the
>>> KERNELRELEASE?
>>
>> CONFIG_LOCALVERSION
>> CONFIG_LOCALVERSION_AUTO
>
> Ah, ok - I feared something less obviously more complex. Do we need  
> this options at all? People can still just edit the EXTRAVERSION  
> line in the Makefile - at least I always did so ...

It makes it easy for people who build a lot of different kernel  
versions and patchsets with similar configs.  When compiling a kernel  
for "aphrodite", I use my "config.aphrodite4" which has  
CONFIG_LOCALVERSION="-aphrodite4".  I may patch the kernel first with  
-mm or another patchset for testing which modify EXTRAVERSION, and  
with the localversion change I get the following kernels, depending  
only on patchset and my config:

/boot/vmlinuz-2.6.15-aphrodite4
/boot/vmlinuz-2.6.15-mm4-aphrodite4
[...etc...]

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/ 
philosophy/) software stuff and not get a real job. Charles Schulz  
had the best answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because life wouldn't have any meaning for them if they didn't.  
That's why I draw cartoons. It's my life."
   -- Charles Schulz


