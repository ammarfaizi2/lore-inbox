Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbRGKSMR>; Wed, 11 Jul 2001 14:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263745AbRGKSL5>; Wed, 11 Jul 2001 14:11:57 -0400
Received: from cr821974-a.lndn1.on.wave.home.com ([24.112.53.173]:39941 "EHLO
	megatonmonkey.net") by vger.kernel.org with ESMTP
	id <S263089AbRGKSL4>; Wed, 11 Jul 2001 14:11:56 -0400
Date: Wed, 11 Jul 2001 14:11:56 -0400
From: "Carlos O'Donell Jr." <carlos@baldric.uwo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting? [MOSIX]
Message-ID: <20010711141156.B32049@megatonmonkey.net>
In-Reply-To: <NOEJJDACGOHCKNCOGFOMOEKECGAA.davids@webmaster.com> <001501c10980$f42035a0$fe00000a@cslater> <3B4C180E.D3AE1960@idb.hist.no> <005f01c10a20$03baf5a0$fe00000a@cslater>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005f01c10a20$03baf5a0$fe00000a@cslater>; from cslater@wcnet.org on Wed, Jul 11, 2001 at 11:41:54AM -0400
X-Useless-Header: oooohhmmm, chant the email mantra...
X-Mailer: Patched Mutt OS 1.2.5 - Neural Implant (47% Sync Ratio [=====.....])
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 11:41:54AM -0400, C. Slater wrote:
> Unless we find some other way to do it, i think we will have to limit this
> to only switching between kernels with the same minor version. We probably
> would not beable to swap between 2.4 and 2.6 anyways, though it depends on
> what changes are made.
> 
>   Colin

Just thinking...

If you had enough money, and were inclined enough, one could setup the
following system:

- 2 Boxes, Running MOSIX (similar processors).

a. Start processes on Box 1.
b. Migrate processes to Box 2.

If the need to upgrade the kernel arises, you can migrate the processes
back to Box 1. Upgrade the kenrel on Box 2, recompile MOSIX.
If the first two digits of the MOSIX version are the same, you can migrate
the processes back to Box 2 (now running the latest kernel).

The stubs inplace for your process will run local kernel functions that
are not specifically host dependant, thus taking advantage of the newer
kernel features, and possibly newer hardware on Box 2, at an application
level.

Obviously, Box 1 could be smaller and less expensive.
Take note that if Box 1 were to fail, you process would die, since the
kernel stubs need to be in place on the original machine.

There are many cons to this system, but I will not ruin the decidely
happy mood of this linux-future-istic conversation ;)

Cheers,
Carlos O'Donell Jr.
-------------------------
Baldric Project
http://www.baldric.uwo.ca
-------------------------


