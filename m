Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUEATdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUEATdc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 15:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUEATdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 15:33:32 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:3591
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S262035AbUEATd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 15:33:29 -0400
Date: Sat, 1 May 2004 15:33:19 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: mbligh@aracnet.com, tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-Id: <20040501153319.6f9ece87.seanlkml@rogers.com>
In-Reply-To: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com>
	<Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
	<90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
	<6900000.1083388078@[10.10.2.4]>
	<772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Sat, 1 May 2004 15:32:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004 15:12:18 -0400
Marc Boucher <marc@linuxant.com> wrote:

> It was already screwed up, and causing unnecessary support burdens
> both on the community ("help! what does tainted mean") and vendors.
> This thread and previous ones have shown ample evidence of that.

Tainting is working just like it is supposed to work.   The reduced
support burden for senior Linux maintainers has been a benefit.

> Let's deal with the root problem and fix the messages, as Rik van Riel
> has suggested.

The kernel maintainers will decide what's best for Linux.   They're the
ones responsible for overseeing Linux.    But if we're going to change
the message i'd prefer something along the lines of:

"Now loading a non GPL driver.   Please consider supporting vendors that
provide open source drivers for their hardware.  Your kernel will now be
marked as tainted, all this means is that you should send any support
requests to the author of this driver."

> Most third-party module suppliers have been confronted with the same 
> issue and forced to work around it (in other imperfect and sometimes
> clumsy ways). One of them redirects the messages to a separate file and
> appends the following notice:
> 
>  > ********************************************************************
>  > * You can safely ignore the above message about tainting the kernel.
>  > * It is completely political and means just that the maintainers of
>  > * of modutils package dislike software that is not distributed under
>  > * an open source license.
>  > ********************************************************************

Tough.   Why don't you understand that LINUX IS AN OPEN SOURCE
OPERATING SYSTEM?   Linux is about open source; accommodating
closed source modules is way way down the list of priorities.

> > What's wrong with the printk setting workaround? Simply write a number
> > to the appropriate file before you load the modules.
> >
> > I just tried googling for the relevant post, but failed...
> >
> > He doesn't need to wait for the patches to propogate. He can act on
> > his own scripts immediately in readiness for the next version.
> >
> > Easy.
> 
> Not. We don't use a script to systematically load the modules,
> because they are large and not always required, nor want to
> interfere with the system's normal logging.
>
> Manipulating printk settings or redirecting the superfluous
> messages elsewhere are also ugly hacks, which can
> potentially also divert/hide important messages.

Good.

Regards,
Sean.
