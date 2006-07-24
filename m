Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWGXP4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWGXP4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 11:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWGXP4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 11:56:32 -0400
Received: from [212.70.63.67] ([212.70.63.67]:7687 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751213AbWGXP4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 11:56:23 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.4 for 2.6.18-rc2
Date: Mon, 24 Jul 2006 18:57:52 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607241857.52389.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
>
> This version removes the hard/soft CPU rate caps from the SPA schedulers.
>
> A patch for 2.6.18-rc2 is available at:
>
> <http://prdownloads.sourceforge.net/cpuse/plugsched-6.4-for-2.6.18-rc2.pat
>ch?download>
>
> Very Brief Documentation:
>
> You can select a default scheduler at kernel build time.  If you wish to
> boot with a scheduler other than the default it can be selected at boot
> time by adding:
>
> cpusched=<scheduler>

Any reason dynsched couldn't be merged with plugsched?

> to the boot command line where <scheduler> is one of: ingosched,
> ingo_ll, nicksched, staircase, spa_no_frills, spa_ws, spa_svr, spa_ebs
> or zaphod.  If you don't change the default when you build the kernel
> the default scheduler will be ingosched (which is the normal scheduler).
>
> The scheduler in force on a running system can be determined by the
> contents of:
>
> /proc/scheduler

It may be really great, to allow schedulers perPid parent, thus allowing the 
stacking of different scheduler semantics.  This could aid flexibility a 
lot.

Worth a try, and should be easy to implement.

> Control parameters for the scheduler can be read/set via files in:
>
> /sys/cpusched/<scheduler>/

Thanks for the most important out-of-tree patch that makes 2.6 reasonable.

--
Al

