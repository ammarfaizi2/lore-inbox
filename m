Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVH1DiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVH1DiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 23:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVH1DiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 23:38:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34271 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751098AbVH1DiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 23:38:11 -0400
Date: Sat, 27 Aug 2005 23:38:02 -0400
From: Dave Jones <davej@redhat.com>
To: Patrick <mccpat@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect CPU Frequency in /proc/cpuinfo
Message-ID: <20050828033802.GA17080@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Patrick <mccpat@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <43112214.7070203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43112214.7070203@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 09:31:48PM -0500, Patrick wrote:
 >  There is a problem with the display of CPU Frequency in /proc/cpuinfo.
 > It displays the CPU Frequency correctly... until you change the speed
 > manually with the kernel's frequency scaling. Before I do this, my
 > frequency displayed in /proc/cpuinfo is: "3208.757", This is correct.
 > Then I: "||echo 600000 /sys/devices/cpu/cpu0/cpufreq/scaling_setspeed"
 > The file "scaling_setspeed" shows 600000, which is correct. My CPU does
 > change to that speed (I've run tests before and after, and temperature,
 > etc), yet /proc/cpuinfo shows no change, no matter what clock speed I
 > set it to.
 > .... 
 > The modules that were modprobed at the time:
 > 
 > p4_clockmod

p4 clock modulation doesn't actually change the cpu frequency.

 > speedstep-lib

This is a support library used by the other speedstep libs.
(It's meant to be pulled in as a dependancy
rather than directly modprobed)

Your CPU isn't supported by the speedstep drivers, so loading
this is pointless. 

 > freq_table

support lib for p4-clockmod.

		Dave
