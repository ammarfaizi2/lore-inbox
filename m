Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVDEVHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVDEVHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVDEVEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:04:52 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:23017 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262013AbVDEVAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:00:49 -0400
Date: Tue, 5 Apr 2005 23:00:41 +0200
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: It's getting worse: 2.6.12-rc2-mm1 and suspend2ram
Message-ID: <20050405210041.GA16263@gamma.logic.tuwien.ac.at>
References: <20050405181628.GB6879@gamma.logic.tuwien.ac.at> <20050405204107.GD1380@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050405204107.GD1380@elf.ucw.cz>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 05 Apr 2005, Pavel Machek wrote:
> I do not know why you can't unload them, but what about simply not
> loading them at all? :-).

hotplug.


Whatever, booting with init=/bin/sh I get these processes running
  PID TTY      STAT   TIME COMMAND
    1 ?        R      0:00 /bin/bash
    2 ?        SN     0:00 [ksoftirqd/0]
    3 ?        S      0:00 [watchdog/0]
    4 ?        S<     0:00 [events/0]
    5 ?        S<     0:00 [khelper]
    6 ?        S<     0:00 [kthread]
    8 ?        S<     0:00 [kacpid]
   98 ?        S<     0:00 [kblockd/0]
  153 ?        S      0:00 [pdflush]
  154 ?        S      0:00 [pdflush]
  155 ?        S      0:00 [kswapd0]
  156 ?        S<     0:00 [aio/0]
  231 ?        S      0:00 [kseriod]
  301 ?        S      0:00 [kjournald]
  309 ?        S<s    0:00 udevd
  553 ?        R      0:00 ps ax

and the same happens. Instant reboot.

So who could be the culprit from the compiled in stuff:
cpufreq
netfilter
input stuff
serio stuff
snd stuff (but not the actual driver snd_interl8x0 which is modular)

well that's it. Strange.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining AT logic DOT at>             Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
AITH (n.)
The single bristle that sticks out sideways on a cheap paintbrush.
			--- Douglas Adams, The Meaning of Liff
