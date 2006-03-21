Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWCUVBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWCUVBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWCUVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:01:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965114AbWCUVBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:01:15 -0500
Date: Tue, 21 Mar 2006 16:01:06 -0500
From: Dave Jones <davej@redhat.com>
To: Sasa Ostrouska <sasa.ostrouska@volja.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: p4-clockmod not working in 2.6.16
Message-ID: <20060321210106.GA25370@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sasa Ostrouska <sasa.ostrouska@volja.net>,
	linux-kernel@vger.kernel.org
References: <1142974528.3470.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142974528.3470.4.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2006 at 09:55:28PM +0100, Sasa Ostrouska wrote:
 > Hello people,
 > 
 > I would like to advise you that in kernel 2.6.16 the 
 > p4-clockmod module cant recognise my P4 cpu anymore.
 > 
 > This worked perfectly in kernel 2.6.15. I get the following
 > error when I modprobe it:
 > 
 > root@rc-vaio:/home/sasa# modprobe msr && modprobe cpuid && modprobe
 > p4_clockmod && modprobe speedstep-lib && modprobe microcode && modprobe
 > hwmon
 > FATAL: Error inserting p4_clockmod
 > (/lib/modules/2.6.16/kernel/arch/i386/kernel/cpu/cpufreq/p4-clockmod.ko): No such device
 > 
 > Can somebody explain what happened or how can I set it up ?

Can you send /proc/cpuinfo and dmesg output please ?
The only thing that recently changed in p4-clockmod is addition
of an errata workaround that disables freqs <2GHz on certain CPUs.

If the max freq is <2GHz this would disable it completely.

		Dave

-- 
http://www.codemonkey.org.uk
