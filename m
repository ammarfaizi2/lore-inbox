Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290165AbSAWW0I>; Wed, 23 Jan 2002 17:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290164AbSAWWZ6>; Wed, 23 Jan 2002 17:25:58 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:4729 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S290157AbSAWWZt>; Wed, 23 Jan 2002 17:25:49 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Ed Sweetman <ed.sweetman@wmich.edu>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Wed, 23 Jan 2002 23:25:46 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0201221801210.11025-100000@infcip10.uni-trier.de> <1011817776.22707.4.camel@psuedomode> <20020123205457.D5FB9141C@shrek.lisa.de>
In-Reply-To: <20020123205457.D5FB9141C@shrek.lisa.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020123222546.70E23141C@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 23. January 2002 21:54, Hans-Peter Jansen wrote:
> On Wednesday, 23. January 2002 21:29, Ed Sweetman wrote:
> > On Wed, 2002-01-23 at 15:16, Hans-Peter Jansen wrote:
> > > On Tuesday, 22. January 2002 18:15, Daniel Nofftz wrote:
> > > > hi there!
> > >
> > > [...]
> > >
> > > > if the patch gets a good feedback, maybe it is something for the
> > > > official kernel tree ?
> > > >
> > > > daniel
> > >
> > > Hi Daniel & folks,
> > >
> > > just tried your patch on my (diskless) asus a7v133 (kt133) with 1.2 GHz
> > > Athlon. I normally had 14% base load spend in apmd-idled and a CPU
> > > temp. of 45°C. After getting it to work, I see a base load of around 1%
> > > (mostly spend in artsd), but CPU is only 1°-2° less now :-( I hoped, it
> > > it would be more). Nevertheless, it is a very important patch nowadays
> > > where temperature is the last technical barrier, and energy saving an
> > > economic necessity.
> > >
> > > Many thanks and greetings from Berlin to Trier ;)
> > >   Hans-Peter
> >
> > 1-2 degrees is within the sensor's deviation.   Either you dont have it
> > working correctly or it doesn't work at all in your case.
>
> It is working somehow, and the 2 degrees are significant in my case,
> because the 45°C is pretty stable in unloaded state with apm enabled. Tmax
> is around 48°C when compiling kde, transcoding divx or the like.
>
> As noted in another message here, I'am going back to apm because it appears
> that vlc became sluggish (& back to 45°C CPU base temp. & ~15% base load
> from apmd-idled, I bet :)

Just testing with ACPI power saving without amd_disconnect. I'm back to
45°C cpuwise, but without 14% background load from apmd. Looks nicer in
gkrellm, but no measurable/noticable difference otherwise. Will stay at
amd unconnected ACPI power savings for now.

Most important: vlc (CVS 0.2.92) is happily working again.

Kernel: linux-2.4.18-pre4+
linux-2.4.18-NFS_ALL.dif (really latest...)
pnpbios.patch_latest
apm-idle-2.diff
btaudio-2.4.17.diff.gz
bttv-0.7.88-2.4.17.diff.gz
imon-0.0.2-2.4.12-hp
00_nanosleep-5.dif
ide.2.4.16.12102001.patch.bz2

Other drivers:
lm_sensors-2.6.2
alsa-driver-0.9.0-beta10

SuSE 7.3 homerolled KDE 2.2.2 NFS diskless setup :-)

> > You also need acpi idle calls, not just apm.   now this is just my guess
> > but apm idle calls might either mess things up or be disabled if acpi
> > idle calls are used and disconnecting the cpu... either way  you can't
> > have this patch work and apm work at the same time.
>
> I know, and I think Daniel should have noted that one have to disable APM
> to get ACPI power savings work. Would have saved me one reboot..

Cheers,
  Hans-Peter
