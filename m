Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278377AbRJMTcb>; Sat, 13 Oct 2001 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278376AbRJMTcV>; Sat, 13 Oct 2001 15:32:21 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:3332 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S278374AbRJMTcE>;
	Sat, 13 Oct 2001 15:32:04 -0400
Date: Mon, 8 Oct 2001 12:20:13 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederman@uswest.net>
Cc: Pavel Machek <pavel@Elf.ucw.cz>, Jeremy Elson <jelson@circlemud.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices
Message-ID: <20011008122013.B38@toy.ucw.cz>
In-Reply-To: <20011002204836.B3026@bug.ucw.cz> <200110022237.f92Mbrk28387@cambot.lecs.cs.ucla.edu> <20011005205136.A1272@elf.ucw.cz> <m1n132x4qg.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <m1n132x4qg.fsf@frodo.biederman.org>; from ebiederman@uswest.net on Sun, Oct 07, 2001 at 08:09:11PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Yep. And linmodem driver does signal processing, so it is big and
> > ugly. And up till now, it had to be in kernel. With your patches, such
> > drivers could be userspace (where they belong!). Of course, it would be 
> > very good if your interface did not change...
> 
> I don't see how linmodem drivers apply.  At least not at the low-level
> because you actually have to driver the hardware, respond to interrupts
> etc.  On some of this I can see a driver split like there is for the video

You don't actually need interrupts -- you *know* when next sample arrives.
And port io is completely fine with iopl() ;-).
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

