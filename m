Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSK0K5K>; Wed, 27 Nov 2002 05:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSK0K5K>; Wed, 27 Nov 2002 05:57:10 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:47376 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262312AbSK0K5J>; Wed, 27 Nov 2002 05:57:09 -0500
Message-ID: <3DE4A6CF.F62CFF41@aitel.hist.no>
Date: Wed, 27 Nov 2002 12:04:47 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.49 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>,
       linux-fbdev-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Fbdev 2.5.49 BK fixes.
References: <Pine.LNX.4.44.0211262306070.30451-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:

> Perfect. I found the problem and I'm about to commit to BK. I posted the
> latest patch against 2.5.49 at
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

I tried this patch, but it crashed during boot.

I have a 
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP
1X/2X (rev 5c)

and use this in lilo.conf:
image=/boot/2.5.49fb
        label=2.5.49fb
        append="video=atyfb:1280x1024-16@85"

This got me a 160x64 framebuffer with yellow text on
blue background.  Nice, but only got about 10 lines before
the kernel hung. The disk light got stuck on and there were
no response to things like sysrq.  
The few lines displayed was about the fb, drm, and finally
the 3com network adapter.  Then nothing more.

2.5.49 without this patch works.  I use devfs & preempt,
the machine is UP and I use gcc-2.95.4 for compiling.

Helge Hafting
