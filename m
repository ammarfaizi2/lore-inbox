Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUANTLz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUANTLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:11:54 -0500
Received: from relay.pair.com ([209.68.1.20]:14354 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S262355AbUANTLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:11:52 -0500
X-pair-Authenticated: 68.42.66.6
Subject: Re: Laptops & CPU frequency
From: Daniel Gryniewicz <dang@fprintf.net>
To: Dave Jones <davej@redhat.com>
Cc: Robert Love <rml@ximian.com>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040114045945.GB23845@redhat.com>
References: <20040111025623.GA19890@ncsu.edu>
	 <20040111025623.GA19890@ncsu.edu> <1073791061.1663.77.camel@localhost>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <E1Afj2b-0004QN-00@chiark.greenend.org.uk>
	 <1073841200.1153.0.camel@localhost>
	 <E1AfjdT-0008OH-00@chiark.greenend.org.uk>
	 <1073843690.1153.12.camel@localhost>  <20040114045945.GB23845@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1074107508.4549.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 14 Jan 2004 14:11:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-13 at 23:59, Dave Jones wrote:
> Of all the implementations I've played with (longhaul/powernow/speedstep-smi)
> speedstep is the only one that does funky shit with SMM. The others are quite
> dumb (and friendly) in comparison. (Ie, nothing happens on power source change)

I have an athlon-xp laptop (HP pavilion ze4500) with powernow that
definitely goes into low power mode when the plug is pulled.  The screen
goes dark, and everything slows down.  And, it appears to be some kind
of percentage of current speed, because if I'm in powersave mode (532000
Hz rather than 1795500), then it gets unbearably slow.  However,
bogomips is not updated when I pull the plug.  I've never run for any
length of time with boot-on-power-then-pull-the-plug, because I only do
that to go from one plug to another.  If I'm running without the plug, I
generally booted that way.  I use the k7-powernow module for my
powersaving.

[14:07:15 athena] dang> cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : mobile AMD Athlon(tm) XP2200+
stepping        : 1
cpu MHz         : 1788.828
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 1777.66

-- 
Daniel Gryniewicz <dang@fprintf.net>
