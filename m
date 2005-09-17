Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbVIQG2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVIQG2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbVIQG2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:28:17 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:48836 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750961AbVIQG2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:28:17 -0400
Message-ID: <432BB77E.3050501@v.loewis.de>
Date: Sat, 17 Sep 2005 08:28:14 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "D. Hazelton" <dhazelton@enter.net>
CC: 7eggert@gmx.de, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4N6EL-4Hq-3@gated-at.bofh.it> <4N7AS-67L-3@gated-at.bofh.it> <E1EGKXl-0001Sn-GA@be1.lrz> <200509170028.59973.dhazelton@enter.net>
In-Reply-To: <200509170028.59973.dhazelton@enter.net>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D. Hazelton wrote:
> This is a bogus argument. You're comparing the way a _binary_ 
> executable works to the way an interpreted _text_ script works. 
> execve(), at least on my system, isn't capable of running a script - 
> if I want to do that from a program I have to tell execve() that it's 
> running /bin/sh and the script file is in the parameter list. 

This being the linux-kernel list, I assume your system is Linux, no?
Well, on Linux, execve *does* support script files. This is the whole
point of my patch - I would not propose a kernel patch to improve
this support if it weren't there in the first place.

> While I appreciate that the kernel is capable of performing complex 
> actions when execve runs into a file that is not an a.out or elf 
> binary I have yet to see a "binfmt script" option in the kernel 
> config files ever.

It's not a config option because it is always enabled. See
fs/binfmt_script.c for details. It wasn't integrated into the binfmt
system until I made it so some ten years ago, though.

> On the other hand, there is the "binfmt_misc" option, which does the 
> work that you seem to be looking for and can, AFAIK, be set to handle 
> both ASCII and UTF-8 scripts. Why add the complexity to the kernel 
> when it's not needed?

One shouldn't add complexity if its not needed. However, this patch
does not add complexity. It is fairly trivial.

Regards,
Martin
