Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVAKEMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVAKEMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 23:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVAKEJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 23:09:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:4604 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262549AbVAKEJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 23:09:05 -0500
Message-ID: <41E35158.4040001@mvista.com>
Date: Mon, 10 Jan 2005 20:08:56 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: high-res-timers-discourse@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] New VST (tick elimination) code
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have just posted a new VST patch for the 2.6.10 kernel.  VST eliminates 
usless time base tick interrupts by, when the system is idle, looking forward in 
the time list to find the next time event.  The time base is then turned off and 
a hardware time is set up to wake the system when the next time event is to happen.

This version uses the local APIC timer(s) so it can sleep for several seconds.

Currently code exists for the i386 platform.  We expect code to support some of 
the ARM and the ppc in time.  Information is provided in the patch on how to do 
the arch dependent code.

All these wonders are to be found at: 
http://sourceforge.net/projects/high-res-timers/

(Note: the VST patch depends on the HRT (high res timers) patch.)
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

