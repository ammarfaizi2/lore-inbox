Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263651AbUCYWSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbUCYWSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:18:00 -0500
Received: from gprs214-160.eurotel.cz ([160.218.214.160]:13697 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263651AbUCYWOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:14:02 -0500
Date: Thu, 25 Mar 2004 23:13:48 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Jonathan Sambrook <jonathan.sambrook@dsvr.co.uk>,
       linux-kernel@vger.kernel.org,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: swsusp is not reliable. Face it. [was Re: [Swsusp-devel] Re: swsusp problems]
Message-ID: <20040325221348.GB2179@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <200403232352.58066.dtor_core@ameritech.net> <20040324102233.GC512@elf.ucw.cz> <200403240748.31837.dtor_core@ameritech.net> <20040324151831.GB25738@atrey.karlin.mff.cuni.cz> <20040324202259.GJ20333@jsambrook> <opr5dwwgzi4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr5dwwgzi4evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Well, not all printks() are errors this hard. And at some points, it
> >>is no longer possible to abort (after pagedir is on disk, its okay to
> >>panic (machine will resume normally after that), but its not okay to
> >>simply return. You could fix signature then return, but it would be hard).
> 
> It is _utterly_ unacceptable to fail  during suspend. You might as well take
> a sledge hammer to kill the box!

Okay, so bring me the sledgehammer.

> Suspend is a mechanism to suspend the system transparently and
> _NOT_EVER_ impairing the system. There can be NO_COMPROMISE and
> NO_EXCUSE. I walk out of my office suspending the machine and resuming it
> in front of my client it can't ever fail, or am I an idiot to advocate 
> linux?
> 
> If I would be willing to accept failure I would not spend my time here and
> utilize M$'s  incarnation of an architectural idiocy.

You are wrong.

swsusp1 fails your test, swsusp2 fails your test, and pmdisk fails it,
too. If half of memory is used by kmalloc(), there's no sane way to
make suspend-to-disk working. And swsusp[12] does not. Granted, half
of memory kmalloc-ed is unusual situation, but it can theoreticaly
happen. Try mem=8M or something.

So stop spreading nonsense about "NO COMPROMISES" and stop comparing
me to Mickey$oft. Thanks.

> Right, because nobody pays attention. If you step on the brake pedal driving
> your car these brakes better work or you may be well worse of than dead
> ... just in case you ran over a kid...

So don't put swsusp into car-braking system.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
