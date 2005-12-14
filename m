Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVLNNCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVLNNCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVLNNCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:02:38 -0500
Received: from main.gmane.org ([80.91.229.2]:22455 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932111AbVLNNCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:02:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Help track down a freezing machine
Date: Wed, 14 Dec 2005 21:55:17 +0900
Message-ID: <dnp4t9$srl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051023)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.93.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

You know there are weeks (or months!) when everything is just plain wrong... While still fighting
with my laptop (See "Help track a memory leak in 2.6.0..14), now one of the semi-production machines
started to freeze without any indication...

No Oops.
Nothing in the logs.
No response to ping, all network is dead.
Trying to log on the console dies at random (sometimes in the middle of the login name entry), but I
can still Alt+SysRq+{S, U,S,B}.
Sometimes no response to any keyboard press...

It is a DIY P4 machine with Asus P5GDC-V-Deluxe (i915G,LGA775), 2GB RAM, SATA WD740GD disk (using
libata).
Running (now) 2.6.14.3 with sk98lin-8.23.1.3 patched in (the in-kernel one does not recognise the
NIC) and mppe-mppc-1.3.patch (using the box to test VPNs). Softwarewise it is a Gentoo machine,
runnig apache-2.0.54, subverison-1.2.3, bugzilla-2.20, mysql-5.0.16, pptpd-1.2.3, ppp-2.4.3 and
latest openss{l,h}. No X, no sound, no WiFi, no USB, no NFSv4 (just 3): it is a headless server-type
box (on a KVM).

When it does die, and lately this happens 2-3 times per 24 hours, there is nothing hwatsoever to
indicate the cause - just dead.

A strange thing is that after the box is restarted with Alt+SysRq+{S, U,S,B}, most of the times it
cannot find the SATA drive (BIOS cannot recognize it), so I need to turn off the power physically.

About the NIC: There are a few posts on the net that Asus shipped some MBs with broken SPD, so they
don't work with linux. Found some king of cryptic patch at Asus site (for another board) and it sayd
to apply cleanly, but NIC is still not recognized by the in-kernel sk98lin at all (flash was done
after problems began, but might have made them appear more frequently?).

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 15)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet Controller (Asus)
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at cfffc000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at d800 [size=256]
        Expansion ROM at cffc0000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
        Capabilities: [e0] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting

Got another NIC and will try it tomorrow.

Now that I get a repetitive freeze, is there anything to debug the problem?
I guess, the point when kernel is still responsive to keyboard, but I cannot login.

It sounds really bad, but a put a cron job to restart the box every 4 hours until I move it's
functions off to another one... and it used to run 30+ days...

Any help is appreciated.
Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

