Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161369AbWKUVY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWKUVY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031436AbWKUVY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:24:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031434AbWKUVY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:24:26 -0500
Date: Tue, 21 Nov 2006 22:24:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vivek Goyal <vgoyal@in.ibm.com>, Pavel Emelianov <xemul@openvz.org>,
       Andre Noll <maan@systemlinux.org>,
       David Rientjes <rientjes@cs.washington.edu>, ak@suse.de,
       discuss@x86-64.org, Prakash Punnoor <prakash@punnoor.de>,
       phil.el@wanadoo.fr, oprofile-list@lists.sourceforge.net,
       David Brownell <david-b@pacbell.net>, Len Brown <len.brown@intel.com>,
       Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>,
       linux-acpi@vger.kernel.org, Ernst Herzberg <earny@net4u.de>,
       Kumar Gala <galak@kernel.crashing.org>,
       Joakim Tjernlund <joakim.tjernlund@transmode.se>,
       Kim Phillips <kim.phillips@freescale.com>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, a.zummo@towertech.it,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Roman Zippel <zippel@linux-m68k.org>, Phil Oester <kernel@linuxace.com>,
       Sam Ravnborg <sam@mars.ravnborg.org>,
       Mattia Dongili <malattia@linux.it>, davej@codemonkey.org.uk,
       cpufreq@lists.linux.org.uk
Subject: 2.6.19-rc6: known regressions (v4)
Message-ID: <20061121212424.GQ5200@stusta.de>
References: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611152008450.3349@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.19-rc6 compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : kernel hangs when booting with irqpoll
References : http://lkml.org/lkml/2006/11/20/233
Submitter  : Vivek Goyal <vgoyal@in.ibm.com>
Caused-By  : Pavel Emelianov <xemul@openvz.org>
             commit f72fa707604c015a6625e80f269506032d5430dc
Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
Status     : problem is being debugged


Subject    : x86_64: Bad page state in process 'swapper'
References : http://lkml.org/lkml/2006/11/10/135
             http://lkml.org/lkml/2006/11/10/208
Submitter  : Andre Noll <maan@systemlinux.org>
Handled-By : David Rientjes <rientjes@cs.washington.edu>
Status     : problem is being debugged


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
             http://lkml.org/lkml/2006/11/15/92
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : problem is being discussed


Subject    : ACPI: AE_TIME errors
References : http://lkml.org/lkml/2006/11/15/12
Submitter  : David Brownell <david-b@pacbell.net>
Handled-By : Len Brown <len.brown@intel.com>
             Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Status     : problem is being debugged


Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Handled-By : Len Brown <len.brown@intel.com>
Status     : problem is being debugged


Subject    : powerpc: serious RTC problems
References : http://lkml.org/lkml/2006/11/17/187
             http://lkml.org/lkml/2006/11/18/99
Submitter  : Kumar Gala <galak@kernel.crashing.org>
             Joakim Tjernlund <joakim.tjernlund@transmode.se>
Caused-By  : Kim Phillips <kim.phillips@freescale.com>
             commit 7a69af63e788a324d162201a0b23df41bcf158dd
             commit a8ed4f7ec3aa472134d7de6176f823b2667e450b
Handled-By : David Brownell <david-b@pacbell.net
             Kim Phillips <kim.phillips@freescale.com>
Patch      : http://lkml.org/lkml/2006/11/20/320
             http://lkml.org/lkml/2006/11/20/321
Status     : patches available


Subject    : xconfig crashes on x86_64
References : http://lkml.org/lkml/2006/11/19/177
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Handled-By : Roman Zippel <zippel@linux-m68k.org>
Patch      : http://lkml.org/lkml/2006/11/20/340
Status     : patch available


Subject    : menuconfig problems with TERM=vt100
References : http://lkml.org/lkml/2006/11/13/369
Submitter  : Phil Oester <kernel@linuxace.com>
Caused-By  : Sam Ravnborg <sam@mars.ravnborg.org>
             commit 350b5b76384e77bcc58217f00455fdbec5cac594
Handled-By : Roman Zippel <zippel@linux-m68k.org>
Patch      : http://lkml.org/lkml/2006/11/20/341
Status     : patch available


Subject    : CPU_FREQ_GOV_ONDEMAND=y compile error
References : http://lkml.org/lkml/2006/11/17/198
Submitter  : alex1000@comcast.net
Caused-By  : Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
             commit 05ca0350e8caa91a5ec9961c585c98005b6934ea
Handled-By : Mattia Dongili <malattia@linux.it>
Patch      : http://lkml.org/lkml/2006/11/17/236
Status     : patch available


