Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132088AbQKQMKe>; Fri, 17 Nov 2000 07:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbQKQMKY>; Fri, 17 Nov 2000 07:10:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:22499 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S132088AbQKQMKF>;
	Fri, 17 Nov 2000 07:10:05 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14869.6415.500026.432150@harpo.it.uu.se>
Date: Fri, 17 Nov 2000 12:39:59 +0100 (MET)
To: Jordan <ledzep37@home.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
In-Reply-To: <3A14FF48.E554BE1B@home.com>
In-Reply-To: <3A14FF48.E554BE1B@home.com>
X-Mailer: VM 6.61 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan writes:
 > I have been running a plug in for xmms for some time that uses the
 > aviplay program and avifile library...then when upgrading to test5/6 I
 > start getting this error message when running xmms:
 > 
 > ERROR: no time-stamp counter found! Quitting.
 > ...
 > contents of /proc/cpuinfo:
 > ...
 > features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca

The 'flags' line in /proc/cpuinfo was recently renamed 'features', due to
some semantic changes. You have a user-space program which parses /proc/cpuinfo
instead of executing CPUID itself, so it breaks.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
