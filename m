Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267242AbUBMXri (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267239AbUBMXqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:46:12 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:12431 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267235AbUBMXp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:45:56 -0500
Date: Sat, 14 Feb 2004 00:45:54 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Cross Compiling
Message-ID: <20040213234554.GA32440@MAIL.13thfloor.at>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040213205743.GA30245@MAIL.13thfloor.at.suse.lists.linux.kernel> <p73n07my8nn.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73n07my8nn.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 10:25:00PM +0100, Andi Kleen wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > 	[ARCH sparc64/sparc]    failed.     failed.
> > 	[ARCH x86_64/x86_64]    failed.     succeeded.
> 
> Your test methology must be broken. 2.4.25rc2 cross compiles 
> just fine here from i386 to x86_64. 

okay, here is the promised update, a little later
as planned, because I discovered that doing 'make dep'
would be a great idea too (well that isn't necessary
for 2.6.x so it doesn't change those results), but
still some archs give troubles ...

  linux-2.4.25-rc2        config  dep     kernel  modules

  alpha/alpha:            OK      OK      OK      OK
  hppa/parisc:            OK      OK      FAILED  FAILED
  hppa64/parisc:          OK      OK      FAILED  FAILED
  i386/i386:              OK      OK      OK      OK
  m68k/m68k:              OK      OK      OK      OK
  mips/mips:              OK      OK      FAILED  FAILED
  mips64/mips64:          OK      OK      FAILED  FAILED
  ppc/ppc:                OK      OK      OK      OK
  ppc64/ppc64:            OK      FAILED  FAILED  OK
  s390/s390:              OK      OK      OK      OK
  sparc/sparc:            OK      OK      FAILED  FAILED
  sparc64/sparc64:        OK      OK      OK      OK
  x86_64/x86_64:          OK      OK      OK      OK

but hey, it's better than before ...

you can get all the details, what and why? it fails
from the logs:

  http://vserver.13thfloor.at/Stuff/Cross/LOGS-2.4.25-rc2/

any help or hints are appreciated, as it would be great
to get this running ...

TIA,
Herbert

> -Andi
