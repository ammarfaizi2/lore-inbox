Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937049AbWLFSgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937049AbWLFSgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937052AbWLFSgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:36:47 -0500
Received: from [212.33.161.70] ([212.33.161.70]:32927 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S937049AbWLFSgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:36:46 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE][RFC] PlugSched-6.4 for  2.6.19
Date: Wed, 6 Dec 2006 21:37:44 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200612062137.44885.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
>
> This version removes the hard/soft CPU rate caps from the SPA schedulers.
>
> A patch for 2.6.19 is available at:
>
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.19.patch?d
>ownload>
>
> Very Brief Documentation:
>
> You can select a default scheduler at kernel build time.  If you wish to
> boot with a scheduler other than the default it can be selected at boot
> time by adding:
>
> cpusched=<scheduler>
>
> to the boot command line where <scheduler> is one of: ingosched,
> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
> or zaphod.  If you don't change the default when you build the kernel
> the default scheduler will be ingosched (which is the normal scheduler).
>
> The scheduler in force on a running system can be determined by the
> contents of:
>
> /proc/scheduler
>
> Control parameters for the scheduler can be read/set via files in:
>
> /sys/cpusched/<scheduler>/

Thanks for keeping this patch in sync with the kernel.

I tried spa_ebs and it still has some hang-ups under load.  Setting 
iab_incr_threshold to 1000 smoothes this, but an obvious mouse-jitter can 
still be observed.

Any hope this could be addressed?


Thanks!

--
Al

