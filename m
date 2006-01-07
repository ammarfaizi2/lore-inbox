Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030254AbWAGAk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030254AbWAGAk4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWAGAk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:40:56 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:23233 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S1030245AbWAGAkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:40:55 -0500
In-Reply-To: <Pine.LNX.4.61.0601061938390.10811@tm8103.perex-int.cz>
References: <20060103215654.GH3831@stusta.de> <9a8748490601031411p17d4417fyffbfee00ca85ac82@mail.gmail.com> <s5hpsn8md1j.wl%tiwai@suse.de> <Pine.LNX.4.61.0601041545580.5750@yvahk01.tjqt.qr> <F082489C-B664-472C-8215-BE05875EAF7D@dalecki.de> <Pine.LNX.4.61.0601051154500.21555@yvahk01.tjqt.qr> <0D76E9E1-7FB0-41FD-8FAC-E4B3C6E9C902@dalecki.de> <1136486021.31583.26.camel@mindpipe> <E09E5A76-7743-4E0E-9DF6-6FB4045AA3CF@dalecki.de> <20060106034026.c37c1ed9.diegocg@gmail.com> <20060106145723.GA73361@dspnet.fr.eu.org> <Pine.LNX.4.61.0601061938390.10811@tm8103.perex-int.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1CE30648-5101-4A2D-A240-64381770A9A6@dalecki.de>
Cc: Olivier Galibert <galibert@pobox.com>, Diego Calleja <diegocg@gmail.com>,
       rlrevell@joe-job.com, jengelh@linux01.gwdg.de,
       Takashi Iwai <tiwai@suse.de>, jesper.juhl@gmail.com, bunk@stusta.de,
       zdzichu@irc.pl, s0348365@sms.ed.ac.uk, ak@suse.de,
       ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       linux@thorsten-knabe.de, zwane@commfireservices.com, zaitcev@yahoo.com,
       LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Sat, 7 Jan 2006 01:40:27 +0100
To: Jaroslav Kysela <perex@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-06, at 21:26, Jaroslav Kysela wrote:
>
> I got the point, but the audio is very specific that it requires  
> realtime
> scheduling. Even graphics is not so tied with realtime, because a
> scheduling gap does not end with error or very ugly misbehaviour  
> (pops)
> like in audio.

Nonsense. You just got too used to utterly bad behavior imposed by  
the inherently defective
X11 graphics system. Like stuttering mouse movements. Like race  
conditions between popup menus
and background menus and so on and so forth... Hick-ups when suddenly  
the system starts to do some paging...
More staggering examples simply don't occur that obviously in praxis  
because the interface
designers refrain from using some effects like subtly animated icon  
change and menu animations
redrawing. But it's by no way an argument which could be used to  
justify the deficiency of
some audio system. And BTW. A proper user interface system requires  
synchronization between
audio and video.

So there you are - all over the pill - soft real time requirements.  
Actually not that soft at all.
It always surprises me how efficient and demanding the perceptive  
system of a hunter and
gatherer is, which only just recently got the sudden idea that it may  
be nice to spend
his time in front of an engine generating animated images.

>> At least OSS, with all its flaws, is a documented kernel interface.
>> You can static link a oss-using program, whether it uses it directly
>> or through interfaces like sdl-audio, and it will just work.
>
> Please, see your words. You're simply anarchistic. You replaced
> flexibility of dynamic library with a possibility to have static  
> binary.

> Also note, that if OSS had the API in userspace from the first days,
> the emulation or redirection of this API to another API or user space
> drivers wouldn't be so much complicated nowadays. Bummer.

You simply don't get it. On unix like systems the definitive  
interface level is not
a library. It's the system call. Libraries can be helpful as a means  
to make some common
actions a tad bit easier. However even so simple things like state- 
full behavior there
is a complete no go. Get over it. Libraries are just too affine to
compiler releases particular programming languages and many other  
side conditions.
Do your homework and take a serious look at other operating systems  
to see how "fine" the
APIs defined by DLLs (ups) are. As an exercise ask yourself why on  
earth it takes
usually about 2 or 4 times longer to write a windows driver.
