Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbTLZXBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLZXBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:01:21 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:21980 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265248AbTLZXBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:01:10 -0500
Date: Fri, 26 Dec 2003 15:00:56 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: azarah@nosferatu.za.org
cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 sound output - wierd effects
Message-ID: <1480000.1072479655@[10.10.2.4]>
In-Reply-To: <1072479167.21020.59.camel@nosferatu.lan>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Martin Schlemmer <azarah@nosferatu.za.org> wrote (on Saturday, December 27, 2003 00:52:47 +0200):

> On Fri, 2003-12-26 at 23:55, Martin J. Bligh wrote:
>> Upgraded my home desktop to 2.6.0. 
>> Somewhere between 2.5.63 and 2.6.0, sound got screwed up - I've confirmed
>> this happens on mainline, as well as -mjb.
>> 
>> If I leave xmms playing (in random shuffle mode) every 2 minutes or so,
>> I'll get some wierd effect for a few seconds, either static, or the track 
>> will mysteriously speed up or slow down. Then all is back to normal for 
>> another couple of minutes.
>> 
>> Anyone else seen this, or got any clues? Else I guess I'm stuck playing
>> bisection search.
>> 
>> Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
>> PCI: Found IRQ 11 for device 0000:00:02.7
>> intel8x0: clocking to 48000
>> ALSA device list:
>> # 0: SiS SI7012 at 0xdc00, irq 11
>> 
>> AMD Athlon(tm) XP 2100+, no power management or ACPI compiled in.
>> 
> 
> I have had this as well, around there, and started using OSS, which
> worked fine (ICH5 onboard - also).  Somewhere when I tried again, it
> worked fine, so this is what I am using now.  What version userland
> libs/utils ?  OSS emulation?
> 
> -- 
> Martin Schlemmer

Dunno - I'm not clued up on sound stuff.

$ egrep  '(SOUND|SND|ALSA|OSS)' /boot/config-2.6.0 | egrep -v '^#'
CONFIG_SOUND_GAMEPORT=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_ENS1371=y
CONFIG_SND_INTEL8X0=y

Userspace stuff is stock Debian Woody, but not sure which libs you
want the version of. The following might help, but probably doesn't

M.

PS. 2.5.70 seems to work as well.

$ apt-cache showpkg xmms
Package: xmms
Versions: 
1.2.7-1(/var/lib/apt/lists/ftp.debian.org_debian_dists_stable_main_binary-i386_Packages)(/var/lib/dpkg/status)

Reverse Depends: 
  eroaster,xmms
  xmms-liveice,xmms
  xmmsarts,xmms
  xmms-wmdiscotux,xmms
  xmms-volnorm,xmms
  xmms-synaesthesia,xmms
  xmms-singit,xmms
  xmms-sid,xmms 1.2.5
  xmms-shell,xmms
  xmms-qbble,xmms
  xmms-osd-plugin,xmms 1.2.0
  xmms-msa,xmms
  xmms-modplug,xmms
  xmms-lirc,xmms
  xmms-jess,xmms 1.0
  xmms-jess,xmms
  xmms-infopipe,xmms
  xmms-goodnight,xmms
  xmms-fmradio,xmms
  xmms-flac,xmms
  xmms-dev,xmms 0.9.5.1-4
  xmms-dev,xmms 1.2.7-1
  xmms-crossfade,xmms
  xmms-cdread,xmms 1.2.5
  xmms-bumpscope,xmms
  xmms-alarm,xmms 1.2
  wmxmms-spectrum,xmms 0.9.5
  wmusic,xmms
  rep-xmms,xmms 1.2.4
  normalize,xmms
  logjam,xmms
  libxmms-perl,xmms
  junior-sound,xmms
  gnomp3,xmms
  gkrellmms,xmms
  gdancer,xmms
  extace,xmms
  eroaster,xmms
Dependencies: 
1.2.7-1 - libc6 (2 2.2.4-4) libglib1.2 (2 1.2.0) libgtk1.2 (2 1.2.10-4) xlibs (4 4.1.0) unzip (0 (null)) gdk-imlib1 (0 (null)) libart2 (2 1.2.13-5) libdb3 (2 3.2.9-1) libgnome32 (2 1.2.13-5) libgnomesupport0 (2 1.2.13-5) libgnomeui32 (2 1.2.13-5) libgnorba27 (2 1.2.13-5) liborbit0 (2 0.5.12) libpanel-applet0 (2 1.4.0.2-3) libwrap0 (0 (null)) libaudiofile0 (0 (null)) libesd0 (18 0.2.23-1) libesd-alsa0 (2 0.2.23-1) libgl1 (0 (null)) libmikmod2 (2 3.1.9) libogg0 (2 1.0rc3-1) libvorbis0 (2 1.0rc3-1) libxml1 (2 1:1.8.14-3) zlib1g (2 1:1.1.3) x11ampg (0 (null)) x11amp (0 (null)) xmms-vorbis (0 (null)) x11ampg (0 (null)) x11amp (0 (null)) xmms-vorbis (0 (null)) 
Provides: 
1.2.7-1 - xmms-vorbis x11amp x11ampg mp3-decoder 
Reverse Provides: 



