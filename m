Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275244AbTHSCH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 22:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275300AbTHSCH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 22:07:29 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:28035
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S275244AbTHSCH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 22:07:28 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jan Rychter <jan@rychter.com>
Subject: Re: Centrino support
Date: Mon, 18 Aug 2003 19:52:08 -0400
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <m2oeyq3bi2.fsf@tnuctip.rychter.com> <1061046769.10596.0.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1061046769.10596.0.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308181952.08577.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 August 2003 11:12, Alan Cox wrote:
> On Gwe, 2003-08-15 at 21:35, Jan Rychter wrote:
> > Question time:
> >
> > 1. Will cpufreq make it into the standard 2.4 kernels?
>
> In time maybe - up to Marcelo.
>
> > 2. If not, will Alan incorporate swsusp into -ac kernels? (given that
> >    -ac kernels seem to have cpufreq included)
>
> Not in its current form. To do the job well swsuspend needs the kernel
> device model.

I've tried it a few times on 2.6.0-test3 right after the system comes up and I 
log in to text mode, and the sucker spits out exactly one line of text 
(something like "Suspending processes:") and hangs with the cursor right 
after the semicolon.  After about a minute I hit ctrl-scroll lock, but 
everything except the suspend thread (which was waiting in some kind of yield 
for other threads to do something) scrolled off the top and I don't know how 
to cursor up to see it (or get it to not scroll off).

I'd be happy to test someting better.  APM suspend doesn't work on my new 
thinkpad, so it's swsusp or nothing.  Currently, it's "shutdown -h now", 
which has some obvious deficiencies...

Rob

