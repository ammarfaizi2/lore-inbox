Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278339AbRJSI2q>; Fri, 19 Oct 2001 04:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278340AbRJSI2g>; Fri, 19 Oct 2001 04:28:36 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:63364 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S278339AbRJSI2e>; Fri, 19 Oct 2001 04:28:34 -0400
From: Christoph Rohland <cr@sap.com>
To: "David E. Weekly" <dweekly@legato.com>
Cc: "ML-linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com>
Organisation: SAP LinuxLab
Date: 19 Oct 2001 10:28:37 +0200
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com>
Message-ID: <m33d4gjaoa.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, 18 Oct 2001, David E. Weekly wrote:
> Hey all,
> 
> I was trying to speed up kernel compiles experimentally by moving
> the source tree into tmpfs and compiling there. It seemed to work
> okay and crunched through the dep phase and most of the main build
> phase just fine, but then it hit a file, got an internal segfault,
> and stopped. I tried again -- this time make itself
> segfaulted. Three more times of make segfaulting -- a strace on make
> didn't reveal what was failing. Then strace started
> segfaulting. Eventually "ls" segfaulted and the machine needed to be
> manually rebooted. Ouch!
> 
> I ran the full memtest86 suite on the machine, and it passed with
> flying colors. So the memory proper is okay.
> 
> I come to one of two conclusions: this is a wierd problem with my
> north bridge, or there's something funky going on with tmpfs.
> 
> Is tmpfs stable?

I merged the tmpfs from -ac into the stock kernel. So there was
something changed which maybe is broken. Were there any kernel
messages, oopses?

Exactly the parallel kernel make is one of my regression tests for
tmpfs. Further on I do not see how tmpfs should interfere with the
library pages. make, ls etc use tmpfs pages. So I suspect it's
something else.

Greetings
		Christoph


