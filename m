Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUGTHEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUGTHEB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 03:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUGTHEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 03:04:01 -0400
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:13444 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S261685AbUGTHDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 03:03:52 -0400
Message-ID: <40FCC3D0.4080304@bigpond.net.au>
Date: Tue, 20 Jul 2004 17:03:44 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] CPU Scheduler Evaluation tool for 2.6.8-rc1
References: <40F9BCE1.5060303@bigpond.net.au>
In-Reply-To: <40F9BCE1.5060303@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> The HYDRA patch for facilitating the comparative evaluation of 
> alternative CPU schedulers is now available for the 2.6.8-rc1 kernel. 
> This patch allows the run time selection of CPU scheduler between a 
> slightly modified version of Con Kolivas's staircase scheduler ("sc") 
> (including the SCHED_BATCH and SCHED_ISO scheduler classes), the 
> priority based scheduler with interactive and throughput bonuses ("pb") 
> and an entitlement based scheduler with interactive and throughput 
> bonuses ("eb").  This patch is available for download at:
> 
> <http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc1-spa_hydra_FULL-v2.0?download> 
> 

Now available for 2.6.8-rc2 at:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.8-rc2-spa_hydra_FULL-v2.1?download>

> 
> The file /proc/sys/kernel/cpusched/mode enables control of which 
> scheduler is in control.  The string "sc" is used to select the 
> staircase scheduler, "pb" to select the priority based scheduler and 
> "eb" to select the entitlement based scheduler described above.  The 
> control of other scheduling parameters is facilitated by other files in 
> the directory /proc/sys/kernel/cpusched as follows (in alphabetical order):
> 
> base_promotion_interval - controls the interval between successive (anti 
> starvation) runnable task promotions (for the "pb" scheduler this is 
> effectively a means to control the "severity" of "nice").  The actual 
> interval will be (number of runnable tasks - 1) times this value in msecs.
> 
> compute - "sc" scheduler boolean parameter
> 
> cpu_hog_threshold - for the "pb" and "eb" schedulers this parameter sets 
> the CPU usage rate (in parts per thousand) above which tasks will be 
> considered to be CPU hogs and start to lose interactive bonus points (if 
> they have any)
> 
> hog_sub_cycle_threshold - for the "pb" and "eb" schedulers this the 
> number of time slices above which calculation of various rates will be 
> made on a per time slice basis rather than a full scheduling cycle (i.e. 
> from one "wake up" to the next).  This is necessary to ensure that very 
> hard CPU spinners usage statistics are representative of the current 
> system state.
> 
> ia_threshold - for the "pb" and "eb" schedulers this is the sleepiness 
> (i.e. the ratio of sleep time per cycle to sleep plus cpu time per 
> cycle) (in parts per thousand) above which a task will be considered to 
> be interactive and have its interactive bonus increased asymptotically 
> towards the maximum.
> 
> initial_ia_bonus - for the "pb" and "eb" schedulers this is the 
> interactive bonus given to newly forked processes.
> 
> interactive - "sc" scheduler boolean parameter
> 
> log_at_exit - boolean parameter to control whether tasks' CPU scheduling 
> statistics are logged at exit
> 
> max_ia_bonus - the maximum interactive bonus that a task can receive
> 
> max_tpt_bonus - the maximum throughput bonus that a task can receive
> 
> sched_iso_threshold - for the "eb" and "pb" this is a CPU usage 
> threshold (in parts per thousand) above which SCHED_ISO tasks will cease 
> to get special treatment
> 
> time_slice - the time slice size in msecs that will be given to each task
> 
> To facilitate the viewing/setting of these parameters a primitive GUI, 
> which also displays per CPU scheduling statistics for the system, is 
> available at:
> 
> <http://prdownloads.sourceforge.net/cpuse/gcpuctl_hydra-1.2.tar.gz?download> 
> 
> 
> Stand alone versions of the three schedulers are available from:
> 
> <https://sourceforge.net/projects/cpuse/>
> 
> The stand alone "pb" and "eb" schedulers do not currently support 
> SCHED_BATCH and SCHED_ISO.
> 
> Peter


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

