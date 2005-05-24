Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVEXCEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVEXCEw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 22:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVEXCEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 22:04:37 -0400
Received: from omta05sl.mx.bigpond.com ([144.140.93.195]:58342 "EHLO
	omta05sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261299AbVEXCEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 22:04:25 -0400
Message-ID: <42928BA7.9040001@bigpond.net.au>
Date: Tue, 24 May 2005 12:04:23 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?S=F8ren_Lott?= <soren3@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-5.0 for 2.6.11, 2.6.12-rc4 and 2.6.12-rc4-mm2
References: <429277A2.50100@bigpond.net.au> <200505232217.33960.soren3@gmail.com>
In-Reply-To: <200505232217.33960.soren3@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05sl.mx.bigpond.com from [147.10.132.202] using ID pwil3058@bigpond.net.au at Tue, 24 May 2005 02:04:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Søren Lott wrote:
> On Monday 23 May 2005 21:38, Peter Williams wrote:
> 
>>A patch of PlugSched-5.0 (containing ingosched, nicksched, staircase,
>>spa_no_frills and zaphod CPU schedulers) against a 2.6.11 kernel is
>>available for download from:
> 
> 
> Does it have any documentation ?

Only that in th KConfig files. :-(

It's fairly simple really.  You can select a default scheduler at kernel 
build time.  If you wish to boot with a scheduler other than the default 
it can be selected at boot time by adding:

cpusched=<scheduler>

to the boot command line where <scheduler> is one of: ingosched, 
nicksched, staircase, spa_no_frills or zaphod.  If you don't change the 
default when you build the kernel the default scheduler will be 
ingosched (which is the normal scheduler).

The scheduler in force on a running system can be determined by the 
contents of:

/proc/scheduler

Control parameters for the scheduler can be read/set via files in:

/sys/cpusched/<scheduler>/

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
