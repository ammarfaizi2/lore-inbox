Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUDEAU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 20:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbUDEAU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 20:20:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19082
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262952AbUDEAUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 20:20:25 -0400
Date: Mon, 5 Apr 2004 02:20:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Sipek <jeffpc@optonline.net>
Cc: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa1
Message-ID: <20040405002028.GB21069@dualathlon.random>
References: <40707888.80006@web.de> <200404041859.47940.jeffpc@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404041859.47940.jeffpc@optonline.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 06:59:41PM -0400, Jeff Sipek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Sunday 04 April 2004 17:05, Marcus Hartig wrote:
> <snip>
> > But now with the vanilla 2.6.5 and/or -aa1 my favourite game Enemy
> > Territory quits with "signal 11". With 2.6.5-rc3 it runs stable for hours.
> >
> > No change in the kernel config, all with preempt, no CONFIG_REGPARM for
> > nVidia binary drivers is set, or other changes. But only when I want to
> > access the net server game browser in ET to play online! Only then bumm!
> 
> Same here (with vanilla 2.6.5, I didn't try -aa.)

did you get an oops or just a sigsegv? (see dmesg) If you only got a
sigsegv can you try to keep the segfaulting process under "strace -o
/tmp/o -p <pid>" and report the last few syscalls before the segfault?
That should reduce the scope of the problem, I had a look at the
diff between rc3 and 2.6.5 final but I found nothing obvious that could
explain your problem (yet).
