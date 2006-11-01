Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946670AbWKAHaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946670AbWKAHaC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 02:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946669AbWKAHaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 02:30:00 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:7838 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1946670AbWKAH37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 02:29:59 -0500
Date: Wed, 1 Nov 2006 08:29:57 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       R.E.Wolff@BitWizard.nl
Subject: Re: preferred way of fw loading
Message-ID: <20061101072957.GA14955@bitwizard.nl>
References: <4547E720.4080505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4547E720.4080505@gmail.com>
Organization: BitWizard.nl
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:15:28AM +0100, Jiri Slaby wrote:
> Hello,
> 
> is preferred to have firmware in kernel binary (and go through array of chars)
> or userspace (and load it through standard kernel api)?

IMHO, from a theoretical point-of-view, I prefer the way it is: 
the driver will upload any firmware you tell it to upload. 

Since writing the driver, some consensus has been reached on how
this is done. This, for example, doesn't involve the misc device
that I use.

> For char sx driver in this case (I hope there is no later fw):
> ftp://ftp.bitwizard.nl/specialix/sx_firmware_306c.tgz

> Now it's 2 .c files used by loader through ioctl. After compilation it has:
>    text    data     bss     dec     hex filename
>       4    8416       2    8422    20e6 si2_z280.o
>       4   19484       2   19490    4c22 si3_t225.o

I see two different processors, there are three.

> So convert it to binary (and load it through userspace) or simply #include it in
> the sources? I hope the former is preferred?

>From a legal point of view, that is undesirable: You'd be linking
the propritary firmware with the kernel, which disallows distribution
of the resulting kernel or module binary. 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
