Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWAFA3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWAFA3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWAFA3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:29:32 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:16622 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S932318AbWAFA3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:29:31 -0500
Message-ID: <43BDB858.5060500@folkwang-hochschule.de>
Date: Fri, 06 Jan 2006 01:22:48 +0100
From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>,
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
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <43BDA02F.5070103@folkwang-hochschule.de> <20060105234951.GA10167@dspnet.fr.eu.org>
In-Reply-To: <20060105234951.GA10167@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Thu, Jan 05, 2006 at 11:39:43PM +0100, Joern Nettingsmeier wrote:
>> modem dialup users know better than to chime in to networking core 
>> discussions and complain they don't need all that complexity. why do 
>> professional audio users always have to put up with people who only 
>> listen to mp3s whining about a complicate API?
> 
> Funnily enough, people who added SIGIO and epoll did not remove
> select nor limited its capabilities.
> 
> The ALSA api has issues, whether you want to acknowledge them or not.
> The OSS api has issues too, of course.  But it is there to stay, and
> it has advantages in some situations, like when simplicity or not
> depending on a shared library matters.  Ignoring it is stupid.  Doing
> your best to cripple it is stupid.  The OSS api is an entrypoint in
> the sound system as valid and important than others.

agreed. nobody doubts this. a long time ago, this thread was about 
removing obsolete *drivers*. that is orthogonal to the api issue.

then people starting whining about bugs in the alsa oss layer, while 
being too lazy to file bug reports. nobody wants to "cripple" this api, 
saying so is just stupid FUD and rather offensive.

then somebody started an api discussion, where *oss* was represented 
quite fairly. it does have its nice sides. but to me it looks like most 
of the people bashing *alsa* for its complexity have not understood the 
problems it tries to (and does) solve.

shuffle 16 tracks of 24bit 48k audio in and out of the machine at a 
latency where a professional drummer will not complain, with routing 
options adequate for professional work, and then let's see how simple 
your API is.
for those audio-challenged people out there: recall the tcp-offloading 
discussions in the networking layer. nobody wants to do it, and they can 
get away with it, because it does not buy you much and fucks up the api 
big time.
in audioland, you have all kinds of funky shit going on in the hardware, 
and you can't say, no we don't support that, to inelegant, because then 
your stuff just can't compete.
hardware peculiarities cannot be abstracted away without sacrificing 
efficiency, and this makes for a complicated api.

instead people keep whining and talk about headsets not working. sheesh.
tomasz, your impressive arithmetic with years is quite correct, but your 
data is wrong. there have been years of development before alsa ever 
came near the kernel. stop bitching, read up on some stuff (for 
instance, find out about how different the gizmos i mentioned actually 
are), get your facts straight. if by then you should happen to develop a 
real interest in audio matters, the linux-audio-* lists welcome your 
questions and contributions.


-- 
jörn nettingsmeier

home://germany/45128 essen/lortzingstr. 11/
http://spunk.dnsalias.org
phone://+49/201/491621

if you are a free (as in "free speech") software developer
and you happen to be travelling near my home, drop me a line
and come round for a free (as in "free beer") beer. :-D
