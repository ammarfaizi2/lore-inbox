Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVEYQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVEYQuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVEYQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 12:50:20 -0400
Received: from one.firstfloor.org ([213.235.205.2]:24971 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262205AbVEYQuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 12:50:05 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, techsupport@tyan.com, support@tyan.de,
       Andrew Morton <akpm@osdl.org>, gl@fenedex.nl, land@hetlageland.nl,
       hans@sww.nl, sww@sww.nl
Subject: Re: Tyan Opteron boards and problems with parallel ports
References: <Pine.LNX.4.44.0505200121410.10661-100000@hubble.stokkie.net>
	<Pine.LNX.4.58.0505191727030.2322@ppc970.osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Wed, 25 May 2005 18:50:03 +0200
In-Reply-To: <Pine.LNX.4.58.0505191727030.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 19 May 2005 17:34:49 -0700 (PDT)")
Message-ID: <m1r7fvxnb8.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 20 May 2005, Robert M. Stockmann wrote:
>> 
>> All problems of Tyan Opteron based machines silently locking up during 
>> installation and/or during normal operation of running Linux, both 
>> 32bit and 64bit, without any display of kernel panic of any other 
>> logging method, seem to be solved when switching off the Parallel Port 
>> inside its BIOS.

The common Tyan problem case is when the machine has more than 3GB
of RAM and "memory remapping" is enabled to recover the memory
below the PCI memory hole. SOmething in that setup leads
to problems and random memory corruption. I suspect a BIOS bug
here.

Workaround is to not enable that option in the BIOS setup.

Then another older Tyan board (it might have been the K8W)
was *extremly* picky in what DIMMs it accepted and in what 
slots because someone apparently didnt follow the AMD specification for 
the memory controller trace lines fully. That also caused common problems. 


> Can you do an install with the thing turned off, and then 
>  - compile the kernel with CONFIG_PCI_DEBUG
>  - boot with the parallel port enabled, and send as much of the bootup 
>    output (and /proc/iomem and /proc/ioport) as possible
>  - boot with the parallel port disabled, and send the same output for that 
>    working case.
>
> I have no clue why the parallel port should matter, but it could change 
> some resource allocation issues.

It is the first time I heard about such a issue so it cannot be too
wide spread anyways. 

-Andi
