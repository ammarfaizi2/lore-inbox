Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318869AbSHWQZ5>; Fri, 23 Aug 2002 12:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSHWQZ5>; Fri, 23 Aug 2002 12:25:57 -0400
Received: from kura.mail.jippii.net ([195.197.172.113]:13185 "HELO
	kura.mail.jippii.net") by vger.kernel.org with SMTP
	id <S318869AbSHWQZ4>; Fri, 23 Aug 2002 12:25:56 -0400
Date: Fri, 23 Aug 2002 19:30:56 +0300
From: Anssi Saari <as@sci.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
Message-ID: <20020823163056.GA7426@sci.fi>
Mail-Followup-To: Anssi Saari <as@sci.fi>,
	linux-kernel@vger.kernel.org
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 06:46:02AM -0400, Alan Cox wrote:

> IDE status
[...]

This new IDE stuff has certainly worsened my longstanding CD writing problem.

Former situation (linux 2.2.19, 2.4.whatever, up to 2.4.19-ac4):

Audio CD writes hog system if writing at > 4x so that CPU intensive
stuff like watching video goes poorly, frames are dropped a lot, even
if video is 160x100 mpeg1 which needs about 1% CPU time. Writing speed
is about 14x according to cdrecord, when trying to write at 16x which
is the drive's max speed. Apparently the writer is smart enough to be
able to limit writing speed on the fly if data doesn't arrive fast enough.
cdrecord's fifo keeps at 0-3% mostly.

Data writes go fine at 16x. Audio writes work fine at 16x in FreeBSD
and Windows 98 with the same system. DMA is on, unmask_irq is on, 32bit
transfers are on, but don't matter much.

New situation (2.4.20-pre2-ac6, 2.4.20-pre4-ac1):

All writes now at no faster than 4x and even at that speed, system
can't keep cdrecord's fifo filled. System is really slow, mouse cursor
moves jerkily, opening an xterm takes several seconds.

System: MSI K7T Turbo-R motherboard, VIA kt133a/686b chipset, Duron 800MHz.
CD writer is LG GCE-8160B in /dev/hdc, main HD is /dev/hda.

No problems otherwise, though, so far.

