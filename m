Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276511AbRJKPYN>; Thu, 11 Oct 2001 11:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276534AbRJKPYE>; Thu, 11 Oct 2001 11:24:04 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:18933 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S276451AbRJKPXv>; Thu, 11 Oct 2001 11:23:51 -0400
Date: Thu, 11 Oct 2001 17:24:17 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard + PS/2 mouse locks after opening psaux
Message-ID: <20011011172417.A3604@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <m3elodw1tv.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3elodw1tv.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.3.22i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 12:21:48PM +0200, Krzysztof Halasa wrote:
> I'm having the following problem: after I start X11 (or gpm with no X)
> my keyboard and PS/2 mouse sometimes locks up. What could that be?

I have the same problem.  However the lockup most often occurs after
switching with Ctrl+Alt+Fx from plain text console to X.  PS/2 mouse +
keyboard, gpm running.

> 440BX UP celeron mobo here (Abit - BH6?), '94 AT keyboard, '2000 A4tech
> 2-wheel mouse, various Linux 2.4 versions (usually -ac, currently 2.4.10ac3).
> I'm using NVidia Xserver module, but it doesn't seem related (the lookup
> occured with no X while starting gpm once or twice).

I had this problem for quite some time with 2.2.x and 2.4.x kernels,
XFree86 3.3.x -- 4.1.0 and S3 Trio3D / NVidia TNT2 M64 / NVidia
GeForce2.  Lockups with S3 convice me that NVidia module is probably
irrelevant here.

> If I kill Xserver (haven't tried with gpm), the keyboard (and mouse) start
> working again (the next Xserver spawn works fine).

I've found out that ssh'ing to the host and running chvt 1 (as root)
helps.  Switching back to X usually works fine.

I haven't tried monitoring /proc/interrupts, but even the magic SysRq
doesn't work during the lock-up.

P.S. I'm not subscribed to linux-kernel.

Marius Gedminas
-- 
"I'll be Bach."  -- Johann Sebastian Schwarzenegger
