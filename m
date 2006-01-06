Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbWAFBau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWAFBau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 20:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWAFBau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 20:30:50 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:25872 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932235AbWAFBas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 20:30:48 -0500
Date: Fri, 6 Jan 2006 02:30:45 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Cc: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
       Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
Message-ID: <20060106013045.GB10167@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Joern Nettingsmeier <nettings@folkwang-hochschule.de>,
	Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>,
	Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Adrian Bunk <bunk@stusta.de>, Tomasz Torcz <zdzichu@irc.pl>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	ALSA development <alsa-devel@alsa-project.org>,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, LKML <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <43BDA02F.5070103@folkwang-hochschule.de> <20060105234951.GA10167@dspnet.fr.eu.org> <43BDB858.5060500@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BDB858.5060500@folkwang-hochschule.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:22:48AM +0100, Joern Nettingsmeier wrote:
> agreed. nobody doubts this. a long time ago, this thread was about 
> removing obsolete *drivers*. that is orthogonal to the api issue.

Yeah, and there was way less flamage then too :-)


> then people starting whining about bugs in the alsa oss layer, while 
> being too lazy to file bug reports. nobody wants to "cripple" this api, 
> saying so is just stupid FUD and rather offensive.

You know, having the problem of device blocking between the oss api
kernel support (emulation is not a very good term in that context) and
the alsa api kernel support being meet by -EWONTFIX and "Don't use
OSS, use Alsa-lib, it's infinitely better" is somewhat offensive too.
You want me to file a bug report on that to see how far it's going to
go?


> then somebody started an api discussion, where *oss* was represented 
> quite fairly. it does have its nice sides. but to me it looks like most 
> of the people bashing *alsa* for its complexity have not understood the 
> problems it tries to (and does) solve.

The "the documentation is perfect, you just not have read it"
fanboyism after having needed 2 or 3 days using that same
documentation to write a simple dynamic sound streaming in an
application I'm doing grates a little.  Also, I notice that all my
comments about the numerous problms as seen in the windows world that
come with having a kernel api defined as a shared library have gone
beautifully ignored.


> shuffle 16 tracks of 24bit 48k audio in and out of the machine at a 
> latency where a professional drummer will not complain, with routing 
> options adequate for professional work, and then let's see how simple 
> your API is.

I've done 64-channel microphone array capture, source tracking,
beamforming, speaker id and feeding an ASR over a network of computers
with a rather low latency.  I wrote or participated in the complete
chain, from programming the capture dsp in assembly and debugging it
with a 'scope, writing the linux driver to get the data on the pci, or
writing the data transmission infrastructure.  And the API is still
simple enough that it is becoming a de facto standard for smart space
applications and the comments are of the order of "there still are
some bugs (indeed there is, no doubts about that), but it allowed us
to having things working rather easily and fast".

Is that enough audio-unchallenged for you?  Oh, it does video too.


> in audioland, you have all kinds of funky shit going on in the hardware, 
> and you can't say, no we don't support that, to inelegant, because then 
> your stuff just can't compete.

That's why you want a clean core and an extension mechanism, and add
the extensions in the core once they're general enough.  See OpenGL.


> hardware peculiarities cannot be abstracted away without sacrificing 
> efficiency, and this makes for a complicated api.

No, it doesn't.  Again, see OpenGL.  Audio hardware variability is
laughable compared to video hardware variability nowadays.

But you need to designed your API starting from what people want to
do, not from what the hardware does in detail.

  OG.
