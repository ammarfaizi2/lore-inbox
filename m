Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267495AbRGMUii>; Fri, 13 Jul 2001 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267486AbRGMUi2>; Fri, 13 Jul 2001 16:38:28 -0400
Received: from [194.213.32.142] ([194.213.32.142]:14852 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267053AbRGMUiP>;
	Fri, 13 Jul 2001 16:38:15 -0400
Message-ID: <20010713011758.A122@bug.ucw.cz>
Date: Fri, 13 Jul 2001 01:17:58 +0200
From: Pavel Machek <pavel@suse.cz>
To: "C. Slater" <cslater@wcnet.org>, linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C92A@mail0.myrio.com> <001501c10a71$68c66820$0200000a@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <001501c10a71$68c66820$0200000a@laptop>; from C. Slater on Wed, Jul 11, 2001 at 09:24:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Would anyone else like to point out some other task somewhat related 
> and have me do it? :-)

Ummm, I need someone to cook me lunch tommorow ;-).

> > > Before you even try switching kernels, first implement a process
> > > checkpoint/restart. The process must be resumed after a boot
> > > using the same
> > > kernel, with all I/O resumed. Now get it accepted into the kernel.
> > 
> > Hear, hear!  That would be a useful feature, maybe not network servers, 
> > but for pure number crunching apps it would save people having to write 
> > all the state saving and recovery that is needed now for long term 
> > computations.
> 
> Get a computer with hibernation support. That's just about what it
> is.

No. Hibernation can be done (see sw_susp patches). This is per-process
-> different. And you could implement that "live upgrade" similar
way. Checkpoint all. Reboot with new kernel. Restart all. That's close
enough to live upgrade.

(Ouch, what are you going to do with programs that behave differently
on different kernel releases? What if you have X using some kernel
driver that goes away in new release?)

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
