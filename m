Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276203AbRI1Rlk>; Fri, 28 Sep 2001 13:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276202AbRI1Rld>; Fri, 28 Sep 2001 13:41:33 -0400
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:36752 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S276201AbRI1RlY>; Fri, 28 Sep 2001 13:41:24 -0400
Date: Fri, 28 Sep 2001 18:40:08 +0100
From: Dave Jones <davej@suse.de>
To: powertweak-linux@lists.sourceforge.net
Cc: linuxperf@nl.linux.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Powertweak 0.99.3
Message-ID: <20010928184008.A2355@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	powertweak-linux@lists.sourceforge.net, linuxperf@nl.linux.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 0.99.3 of the multi-purpose performance tuning / hardware
configuration tool 'Powertweak' has been released.

You can find tarballs at
	http://sourceforge.net/project/showfiles.php?group_id=253
RPMs/Debs will follow soon.

regards,

Dave.

Release notes follow:
v0.99.3 [Release 21. -- The 'voon' release ]

- Bugfixes:
  - Daemon now handles >1 HUP. 
  - Daemon applies settings on getting a HUP.
  - SMART code doesn't keep device fd open anymore.
  - Make install no longer overwrites existing config files.
  - CDROM backend now respects min/max settings in /proc
  - CPU backend now handles SMP boxes properly.
  - CPU backend handles steppings correctly.
  - Close open fds lying around at daemon creation time (Debian bug 111840) 

- New Features:
  - Tweaks that have changed value since the daemon has loaded
    now reflect their current state in the UIs.
  - Subtrees are now sorted alphabetically in UIs. 
  - Powerdown joystick port option for ymf744b sound card.
  - Daemon --no-info option to skip `info' tweaks. 
  - Pentium III & AMD Athlon XML added.
  - Informational MTRR backend added.

- Architectural changes:
  - CPU backend now only does CPU identification once
    at init time, not every time a tweak is allocated.
    End result : Lower backend memory usage.
  - All backends had destructors auditted & cleaned up.
  - Addition of GetValueRaw() method to tweak struct meant
    backend init paths got much cleaner.
  - Removal of lots of useless/old/duplicated code.
  - Tweak allocation methods changed to accept tweaktype argument.
  - Standarise some XML tags between backends.
  - powertweakd now becomes a daemon before loading tweaks.

-- 
| Dave Jones.                    http://www.codemonkey.org.uk
| SuSE Labs .
