Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWAFABV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWAFABV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWAFABU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:01:20 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:5309 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S932290AbWAFABR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:01:17 -0500
In-Reply-To: <43BDA02F.5070103@folkwang-hochschule.de>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de> <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl> <mailman.1136368805.14661.linux-kernel2news@redhat.com> <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl> <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz> <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl> <43BDA02F.5070103@folkwang-hochschule.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=UTF-8; delsp=yes; format=flowed
Message-Id: <F2397D74-197C-4115-9626-F9BFA42215B2@dalecki.de>
Cc: =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [OT] ALSA userspace API complexity
Date: Fri, 6 Jan 2006 01:00:58 +0100
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-05, at 23:39, Joern Nettingsmeier wrote:

> Tomasz Kłoczko wrote:
>> List all neccessary feactures and abstract them. Below this layer  
>> you can plug to this all device drivers. Where is the problem ?
>
> users want to use all the bells and whistles that modern sound  
> hardware has to offer. so "necessary features" roughly equals the  
> union of all the "cool ideas of the week" of all soundcard vendors.

First and fore most users want simple things like for example playing  
an mp3 file to just work.
Your concept that very many of them are interested in the high end  
"features" of hardware you assume to be modern is wrong. Did you ever  
notice that sound cards got just reduced to a simple AD/DA converter  
combination? Modern hardware is frequently actually MUCH MUCH simpler  
then old one used to be in this area.

> please have a look at, say, the rme hammerfall cards, compare them  
> with ye olde sblive, then take a look at usb audio devices and for  
> dessert, take a peek into current firewire hardware.

The existence of /dev/sound doesn't prohibit the existence of
/dev/bells_and_wistles (without any chance to work with anything else  
then the vendors specific software).
That was precisely the situation with my sam9700 card....

> then push up your sleeves, design a small and elegant little  
> abstraction mechanism that is maximally effective in all  
> circumstances and makes all hardware features usable, wrap it up  
> nicely and submit it to linus.
>
> i look forward to hearing back from you, in, oh, 2015 or so?

Your assumption about "all circumstances" is misguided. There is no  
requirement for one size fits all here.
Look most people drive cars and not space shuttles.


> jaroslav, takashi and the other alsa developers have been toiling  
> with this for years, and i hate to see them having to take shit  
> from people who don't do anything more with their sound hardware  
> than listen to mp3s in stereo and can't imagine anything else.

If hearing just the mp3 would just simply work with the alsa drivers  
without getting in to too much hassle
with AC97 sound cards, which usually don't even include hardware  
based volume controls nowadays, I'm pretty sure they wouldn't have to  
"take this shit". And you should remember the bold announcements they  
did make in first place.

> granted, there is always room for improvement. the alsa guys are  
> very receptive towards constructive criticism, when it is backed  
> with a little insight. many linux audio developers have criticised  
> the API for the high initial barrier, and ALSA certainly does not  
> score that high in the "making simple things simple" department.  
> but it does make *complicated things possible*, and all those rants  
> of "gimme back me oss" usually ignore this.
>
> modem dialup users know better than to chime in to networking core  
> discussions and complain they don't need all that complexity. why  
> do professional audio users always have to put up with people who  
> only listen to mp3s whining about a complicate API?
> i'll always grant you far better taste and insight into kernel  
> matters than i will ever have, but hey: the library is in  
> userspace. it does not clutter the kernel. so rrreeelaax!

It clutters the application programming part very successfully.

BTW. Designing a sound API toward DMA, like ALSA does, is just plain  
well beyond any hope...
