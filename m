Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290267AbSAXGAK>; Thu, 24 Jan 2002 01:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290269AbSAXF7u>; Thu, 24 Jan 2002 00:59:50 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:5893 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290267AbSAXF7l>; Thu, 24 Jan 2002 00:59:41 -0500
Date: Thu, 24 Jan 2002 06:59:15 +0100
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Quick question about 2.4.18-pre7.
Message-ID: <20020124055915.GB2018@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <3C4F7F92.564A4989@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C4F7F92.564A4989@starband.net>
User-Agent: Mutt/1.3.25i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 10:29:22PM -0500, Justin Piszcz wrote:
> - Fix 3dfx fb crash with high pixelclock        (Jurriaan on Alpha)
> 
> I see that there is a 3DFX fix with high pixelclock.
> 
> Without the fix, could this be a reason why my machine locks up when
> I am scrolling through various MPG or DIVX movies with mplayer
> (sometimes)?
> 
> I have a 3DFX Voodoo 3 3000 AGP.
> 
I wrote the fix, so here goes:

the fix only applies if you run your DAC at over half the maximum speed.
That means that with a Voodoo 3 you'd need a 150 MHz pixelclock to
trigger it. If you run linux using no framebuffer or a framebuffer at
frequencies below that, nothing is changed, and you'll need to find
another culprit. If you run above that, you could try to copy in
tdfxfb.c from the previous version. If that fixes it, I've got a
problem.

Anybody with a voodoo card and running high-frequency framebuffer:
please post your experiences.

Thanks,
Jurriaan
-- 
***************************** WARNING *****************************
Linux should not be used by those under the influence of MicroSoft.
May cause dissiness or vertigo. Consult your tech support before
using Linux. (note--after using Linux, you may notice extreme dis-
comfort when using MicroSoft. Discontinue use of Microsoft.)
***************************** WARNING *****************************
GNU/Linux 2.4.18-pre6 on Debian/Alpha 64-bits 990 bogomips load:0.03 0.22 0.18
