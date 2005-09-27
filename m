Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbVI0UQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbVI0UQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVI0UQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:16:07 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:31913 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750958AbVI0UQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:16:06 -0400
Date: Tue, 27 Sep 2005 22:16:05 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: "Carlo J. Calica" <ccalica@gmail.com>
Cc: linux-kernel@vger.kernel.org, xorg@freedesktop.org
Subject: Re: kernel 2.6.13, USB keyboard and X.org
Message-ID: <20050927201605.GB8055@janus>
References: <433191A2.9030702@terra.com.br> <dh4phg$e4r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dh4phg$e4r$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 05:04:17PM -0700, Carlo J. Calica wrote:
> Piter Punk wrote:
> 
> > But, when i start X i got a second problem, is impossible to type
> > only one letter, one touch in a key makes a lot of letters, like that:
> > 
> > lllllliiiiiiinnnnnnnnuuuuxxxxx
> > 
> > instead
> > 
> > linux
> > 
> 
> I have the same problem, with my dual core athlon64.  Booting a uniprocessor
> kernel solves it.  Another work around is turning off key repeat.
> 
> Best solution is setting processor affinity for the keyboard irq handler and
> X to the same cpu.  Seems to be a race condition of some sort.  If a X

You just might be hitting a TSC related problem, see bug #5105 at
bugzilla.kernel.org. In that case you will probably see funny timings
when doing an strace -tt of the xclock program, for example.

A workaround for i386 kernels is "clock=pit" on the kernel commandline.
In x86_64 mode, try "notsc" instead. Well, try that anyway but it didn't
work in my case.

-- 
Frank
