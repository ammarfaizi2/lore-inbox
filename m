Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbTAKFMh>; Sat, 11 Jan 2003 00:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTAKFMg>; Sat, 11 Jan 2003 00:12:36 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:17671 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266359AbTAKFMf>; Sat, 11 Jan 2003 00:12:35 -0500
Subject: Re: [Linux-fbdev-devel] [RFC][PATCH][FBDEV]: Setting fbcon's
	windows size
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301092140020.5660-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0301092140020.5660-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042255015.932.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Jan 2003 13:10:58 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-11 at 02:18, James Simmons wrote:
> 
> > Here's an improved GTF implementation.  I was a bit delayed because I
> > was trying to find a way to do square roots without using floating
> > point.  The diff is against linux-2.5.54 + your latest fbdev.diff.
> 
> Applied. 
> 
> > but is more or less usable.  Tested with i810fb and rivafb. (For rivafb,
> > I have to use a hacked version. The latest one does not work for the
> > riva128).
> 
> What hack did you do? That is based on the latest riva driver from 2.4.2X.
>  
I just combined the old riva_hw.c in linux-2.5.52 with the new fbdev.c
code.  Not too sure why, either the newest riva_hw.c has dropped support
for old hardware, or we are using it incorrectly.  If I'm to guess, the
new riva_hw.c did not come from linux-2.4.20, but probably from Xfree86?

> > BTW, I downloaded the source code of read-edid, and it seems that the
> > following monitor limits are parsable from the EDID block: HorizSync,
> > VertRefresh, DotClock, and GTF capability. We may change info->monspecs
> > to match that. Also, the EDID contains a list of supported modes, but
> > there's only 4 of them(?).  
> 
> I figured monspec would have to be improved. I'm looking into the EDID 
> info right now. I'm also looking at read-edid. Next I need to figure out 
> how to use i2c to get this info.
> 
Good luck :-)

Tony


