Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVJ3VWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVJ3VWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVJ3VWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:22:14 -0500
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:3022 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S932080AbVJ3VWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:22:14 -0500
Message-ID: <4365394B.4000907@tremplin-utc.net>
Date: Mon, 31 Oct 2005 06:21:15 +0900
From: Eric Piel <eric.piel@tremplin-utc.net>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: cpufreq driver + wrong cpu time
References: <1130677884.3318.15.camel@m00>
In-Reply-To: <1130677884.3318.15.camel@m00>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Shaposhnikov wrote:
> Hello to everyone.
> 
Hello Alexander,

> I have written cpufreq_nForce4 kernel driver for  cpufreq subsystem.
> It allows for CPU frequency changing by adjusting FSB speed, for nForce4
> based motherboards. 
> Works for single-cpu systems, as well as for SMP.
> The problem is, after changing CPU(s) speed on SMP systems, programs
> report wrong cpu time (wall time is OK). 
What do you mean by CPU time? Do you mean the output of "time foo" ? How 
do you know the *right* CPU time? Could you provide some examples :-)

Well, anyway, by _rough_ guess, if on UP it works and on SMP it doesn't, 
we could imagine that the difference comes from the fact the tick 
interrupt source is not the same on those systems. You could try to boot 
a UP kernel with local APIC (selectable in the .config) on the 
multi-processor computer to check. Then it might mean that after 
changing the FSB speed, the interrupt source has to be re-programmed...

> What would be the best way to fix this, and shouldn't this be done by
> the cpufreq subsystem, rather than by hardware driver? 
> 
Probably the best place to discuss about cpufreq is the dedicated 
mailing list : cpufreq@lists.linux.org.uk . If you don't mind, you could 
  continue there.

Also please, provide the sources of your driver to have a look :-)

cu,
Eric
