Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264860AbUF1H06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264860AbUF1H06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 03:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUF1H06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 03:26:58 -0400
Received: from pD9542CA1.dip.t-dialin.net ([217.84.44.161]:59264 "EHLO
	cylob.rephlex.local") by vger.kernel.org with ESMTP id S264860AbUF1H04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 03:26:56 -0400
Message-ID: <40DFC853.20803@bigfoot.com>
Date: Mon, 28 Jun 2004 09:27:15 +0200
From: Frederic Krueger <spamalltheway@bigfoot.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040625)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: io apic + tsc = slowdown (bugreport + possible fix)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just wanted to point out the patch I imported from an older version of 
the 2.6.x kernel (not done by me at all ;-)).
It's basically causing the system to a near zero slowdown after one hour 
of uptime. And the reason for it must be the io_apic irq0 handling with 
TSC enabled systems (seems to show up on ibm pre-built boxes more often 
than on others though).
Funnily pressing any keys _all the time_ works around for this for the 
time a key is pressed ;)

The bug report entry contains a patch for arch/i386/kernel/io_apic.c  
which fixed it for me.
Maybe this should make it into the cvs tree since it's a _really_ 
annoying bug, basically rendering the computer unusable if present.

The link to the bug report with more detailed information can be found here:
http://bugme.osdl.org/show_bug.cgi?id=2964

Thanks for checking and considering :-)

Bye,
Frederic


