Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbVHSHlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbVHSHlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 03:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVHSHlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 03:41:12 -0400
Received: from claven.physics.ucsb.edu ([128.111.16.29]:9381 "EHLO
	claven.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S964888AbVHSHlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 03:41:11 -0400
Date: Fri, 19 Aug 2005 00:41:07 -0700 (PDT)
From: Nathan Becker <nbecker@physics.ucsb.edu>
To: linux-kernel@vger.kernel.org
Subject: lost ticks and Hangcheck
Message-ID: <Pine.LNX.4.63.0508182351460.6338@claven.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running kernel 2.6.12.5 with x86_64 target on an AMD X2 4800+ and 
Gigabyte GA-K8NXP-SLI motherboard (bios version F8).  I'm having a problem 
with lost clock ticks.  The dmesg says

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts

Also if I enable hangcheck, then I get a huge number of Hangcheck messages 
in dmesg.

The main other symptom is that the system clock runs fast and 
inaccurately.  It seems to run more inaccurately when I'm using the CPU, 
and be basically OK when idling.

I've tried various workarounds that I found suggested on this list and 
others but the problem is still there.  I tried using noapic, turning on 
RTC interrupt, also no_timer_check.  I also tried patching the CPU 
frequency scaling code with the latest version from the AMD website 
(1.50.03), and then finally turning that option off. Nothing helped.

I'm not sure if this is a bug in the kernel or if I'm just doing something 
incorrectly.  Any thoughts or suggestions, or if is a bug then ETA for a 
fix, would be much appreciated.

I'm not a regular subscriber to this list, so please cc any responses 
directly to me.

thanks very much,

Nathan
