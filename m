Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSAXSZ5>; Thu, 24 Jan 2002 13:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288859AbSAXSZr>; Thu, 24 Jan 2002 13:25:47 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:1916 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S288801AbSAXSZL>; Thu, 24 Jan 2002 13:25:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Date: Thu, 24 Jan 2002 19:25:02 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201241223260.28872-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.33.0201241223260.28872-100000@coffee.psychology.mcmaster.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020124182502.80418146E@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 24. January 2002 18:24, Mark Hahn wrote:
> > > > 1-2 degrees is within the sensor's deviation.   Either you dont have
> > > > it working correctly or it doesn't work at all in your case.
> > > >
> > > > You also need acpi idle calls, not just apm.   now this is just my
> > > > guess but apm idle calls might either mess things up or be disabled
> > > > if acpi idle calls are used and disconnecting the cpu... either way 
> > > > you can't have this patch work and apm work at the same time.
> > >
> > > or the vlc makes enough load on the mashine that there is no realy
> > > power saving ...
> >
> > No, vlc creates between 15% and 25% load, when using XVideo output
> > without
>
> the issue is whether there is a long-enough period of idleness.
> what's your framerate?  that's what matters, not the (known-inaccurate)
> %CPU accounting.

Ordinary pal encoded mpeg2 files plays with 25 frames per sec.

As I wrote, vlc plays smooth and fine _without_ amd_disconnect with the
documented load. With disconnect, vlc suffers from sound drop outs but I 
haven't digged further in this vlc issue, as it was clearly related to the 
cpu disconnect feature. Also, there were noticable delays in actions
like starting a Xterm via shortcut of approx. 0.5 sec, which I don't
see without disconnect.

Because of the mutual exclusive nature of this feature, I filed it
under unfinished hardware feature.

On behalf of power saving, I will look into swsusp/ACPI suspend again soon.

Cheers,
  Hans-Peter
