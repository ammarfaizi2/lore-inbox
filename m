Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVCaWIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVCaWIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 17:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbVCaWIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 17:08:43 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:27826 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262015AbVCaWI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 17:08:28 -0500
Date: Fri, 1 Apr 2005 00:08:22 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050331220822.GA22418@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew, dear developers!

Since 2.6.12-rc1-mmX I cannot get suspend2ram working again as it was
with 2.6.11-mm4 with the same .config.

I suspends fine, but never resumes. No CapsLock, no sysrq, no network is
working. Nothing in the log files. Is there anything which may cause
these troubles when compiled into the kernel and not loaded as module?
(as it was with my usb stuff until 2.6.11-mm2, after this I had to stop
hotplug, before I could go with usb running).


On a side node: Once suspend2ram couldn't stop all tasks, in fact
cpufreq, although it was stopped with /etc/init.d/cpufreqd stop, was
mentioned in syslog as not being able to be stopped, and after this
halfway through suspend, my touchpad (synaptics) and kbd wasn't working
anymore.  After resume the touchpad is somehow behaving strange.
THe touchpad is not working at all, the keyboard seems to react to some
events (Sysrq is working, but normal typing not, nor power button/acpi
stuff).

In the syslog I find:
vmunix: psmouse.c: TouchPad at isa0060/serio1/input0 lost synchronization, throwing 4 bytes away.
vmunix: psmouse.c: TouchPad at isa0060/serio1/input0 lot sync at byte 1

I would be happy to test some stuff to get S2R back to work!

Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HARBLEDOWN (vb.)
To manoeuvre a double mattress down a winding staircase.
			--- Douglas Adams, The Meaning of Liff
