Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVC3EOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVC3EOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVC3EOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:14:41 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51138 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261524AbVC3EOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:14:39 -0500
Subject: Re: Mac mini sound woes
From: Lee Revell <rlrevell@joe-job.com>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Takashi Iwai <tiwai@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <0683ecb1e5fb577a703689d1962ad113@dalecki.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
	 <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
	 <1112084311.5353.6.camel@gaston>
	 <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
	 <s5h7jjqkazy.wl@alsa2.suse.de>
	 <0683ecb1e5fb577a703689d1962ad113@dalecki.de>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 23:14:37 -0500
Message-Id: <1112156077.5598.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 03:45 +0200, Marcin Dalecki wrote:
> > I think your misunderstanding is that you beliieve user-space can't do
> > RT.  It's wrong.  See JACK (jackit.sf.net), for example.
> 
> I know JACK in and out. It doesn't provide what you claim.
> 

This was just an example, to prove the point that user space can do RT
just fine.  JACK can do low latency sample accurate audio, and mixing
and volume control are fairly trivial compared to what some JACK clients
do.  If it works well enough for professional hard disk recording
systems, then it can certainly handle system sounds and playing movies
and MP3s.

And as a matter of fact you can implement all the audio needs of a
desktop system with JACK, this is what Linspire is doing for the next
release, even though it wasn't designed for this.  The system mixer is
just a JACK mixing client and each app opens ports for I/O, and only
JACK talks to the hardware (through ALSA).

The fact that OSX and Windows do this in the kernel is not a good
argument, those kernels are bloated.  Windows drivers also do things
like AC3 decoding in the kernel.  And the OSX kernel uses 16K stacks.

If audio does not work as well OOTB as on those other OSes, it's an
indication of their relative maturity vs JACK/ALSA, not an inherently
superior design.  Most audio people consider JACK + ALSA a better design
than anything in the proprietary world (CoreAudio, ASIO).

Lee



