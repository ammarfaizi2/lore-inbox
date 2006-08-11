Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWHKSkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWHKSkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWHKSkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:40:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750831AbWHKSkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:40:31 -0400
Date: Fri, 11 Aug 2006 14:39:54 -0400
From: Dave Jones <davej@redhat.com>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
Message-ID: <20060811183954.GH26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Mark Lord <lkml@rtr.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <44DCCB96.5080801@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44DCCB96.5080801@rtr.ca>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 02:25:26PM -0400, Mark Lord wrote:
 > One of my notebooks (Dell Latitude X1) has a 1.1GHz Pentium-M ULV processor.
 > This chip can change CPU speeds from 600 -> 800 -> 1100 Mhz.
 > 
 > I use speedstep-centrino with it, and after boot all is usually okay.
 > But after a few hours of operation, it stops shifting to the highest frequency
 > even under continuous 100% load (or not).  Eventually it gets stuck at 600Mhz
 > and stays there until I reboot.
 > 
 > Sometimes rebooting doesn't even restore it.
 > 
 > /sys/devices/system/cpu/cpu0/cpufreq is all very normal looking,
 > showing the available frequencies and other info.  All of the attribs
 > there look fine, except for "scaling_max_freq", which is what seems
 > to gradually get set smaller.  For instance, right now it is set to 800000,
 > and it won't let me change it (echo 11000000 > scaling_max_freq has no effect.
 > 
 > WHY?  And how can I fix it?

boot with cpufreq.debug=7, and capture dmesg output after it fails
to transition.  This might be another manifestation of the mysterious
"highest frequency isnt accessable" bug, that seems to come from
some recent change in acpi.

		Dave

-- 
http://www.codemonkey.org.uk
