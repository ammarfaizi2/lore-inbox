Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUEMHTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUEMHTi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 03:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbUEMHTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 03:19:36 -0400
Received: from firecat.admindu.de ([213.178.172.5]:18312 "EHLO mail.admindu.de")
	by vger.kernel.org with ESMTP id S263895AbUEMHTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 03:19:08 -0400
Message-ID: <40A33DA2.70708@kurtenba.ch>
Date: Thu, 13 May 2004 11:19:30 +0200
From: clemens kurtenbach <moqua@kurtenba.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 MultiZilla/1.6.3.0d
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cpufreq and p4 prescott
References: <20040512171433.GA10481@dominikbrodowski.de>
In-Reply-To: <20040512171433.GA10481@dominikbrodowski.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>[ck@holodeck:cpufreq] cat /proc/cpuinfo | grep Mhz
>>cpu MHz         : 2807.131
>>cpu MHz         : 2807.131
> 
> The cpu MHz entry in /proc/cpuinfo is the same for all CPUs, and no reliable
> source to detect the current cpu frequency anyway.  Use

i thought this because on my ibook i can see different MHz
entry's when cpudyn changes the frequence.

> /sys/devices/system/cpu/cpu0/scaling_cur_freq or even cpuinfo_cur_freq for
> that.[*] So p4-clockmod-throttling does work on your p4 prescott.
> 
> 	Dominik
> 
> [*] Available in 2.6.7, hopefully, if Linus merges the latest cpufreq-bk
> tree from Dave. It'll be in the next -mm release, though.

o.k, when i understand you right p4-clockmod-throttling _is working_
on my system, but i can't see this in /sys until Dave Jones
patches are includet. So i patched my 2.6.6 kernel with
cpufreq-2004-05-13.diff.

Now cpuinfo_cur_freq and scaling_cur_freq show changing entry's
when eg powernowd handles the frequence.

The reason why i want to throttle down my prescott is the heat.
Strange is that when the frequence is changed to 350MHz
(after 30min running with 2.8GHz), neither the CPU&System temperature
nor tools that calculate the CPU speed (like gkrellm-x86info)
show a difference to 2.8GHz. All voltages on my system are the
same with 350MHz/2.8GHz, too.

So i'm not sure if throttling does work until now?

thanks,
clee
-- 
moqua [at] gmx.net
moqua [at] kurtenba.ch

