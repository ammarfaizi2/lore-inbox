Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133094AbRDLOs0>; Thu, 12 Apr 2001 10:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133091AbRDLOsG>; Thu, 12 Apr 2001 10:48:06 -0400
Received: from marine.sonic.net ([208.201.224.37]:36937 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S133084AbRDLOsC>;
	Thu, 12 Apr 2001 10:48:02 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Thu, 12 Apr 2001 07:48:00 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: PS2 mouse data point
Message-ID: <20010412074800.A16976@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just an interesting data point here.

A while back (8-10 months ago), I'd thought I'd blown my ps2 mouse port on
my motherboard and was using a serial mouse.  Having just moved and
reconnecting everything, I decided to give it a try again.

Built kernel 2.4.2.

Basically, I got the problem down to this:

cat /dev/psaux

Hit keyboard... instant lockup.  (well, if I had the network up yet, I
might have been able to telnet in, I'm not certain at this time)

It turns out the ps2 mouse port was disabled in the BIOS and one of the two
ethernet cards (dsl+homenetwork) was getting IRQ 12.  Things weren't too
happy (actually, fact that a network card was causing the conflict could
have prevented network from working.  Have to try that sometime).

Anyway, I simply enabled the stupid thing in the BIOS and everything is
working great.

I just find it odd that if I had that disabled in the BIOS that catting
/dev/psaux would cause any problems what so ever.  I'm not sure what would
happen if I tried to cat /dev/psaux with no mouse attached and disabled in
BIOS.  But I could see where some system might try to auto detect mice and
the system "lock up."

Also, I'd seen several posts about similar issues in the linux-kernel
archive, but no documented solution.  Certainly nothing so simple as
"enable the stupid thing in BIOS."  So for archival sake... here it is.

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
