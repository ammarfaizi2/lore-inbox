Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVCWRwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVCWRwb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 12:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVCWRwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 12:52:31 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:15056 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262003AbVCWRw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 12:52:28 -0500
Date: Wed, 23 Mar 2005 12:52:26 -0500
From: Tom Vier <tmv@comcast.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>, Dan Maas <dmaas@maasdigital.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Distinguish real vs. virtual CPUs?
Message-ID: <20050323175226.GB3272@zero>
Reply-To: Tom Vier <tmv@comcast.net>
References: <88056F38E9E48644A0F562A38C64FB600448EE27@scsmsx403.amr.corp.intel.com> <42408D97.7000806@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42408D97.7000806@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 04:26:47PM -0500, Bill Davidsen wrote:
> It's not clear if that's bizarre practice on AMD system boards or if 
> it's mis-reported. Of course Tom may be running a NUMA setup, in which 
> case I won't guess what's expected to be displayed. I've added him to 
> the CC list, in hopes of comment.

It's numa (two cores, one ram ctrlr per core, one core per package). I'm
running an x86 kernel, btw, not 64bit. I have CONFIG_X86_HT set, and it
looks like it gets the pkg id from the apic (there's only one in multicore
packages?), but i might be reading it wrong.

My dmseg overflows before syslog starts, so all i could gather is: 

Mar 23 12:04:25 zero kernel: Brought up 2 CPUs
Mar 23 12:04:25 zero kernel: CPU0 attaching sched-domain:
Mar 23 12:04:25 zero kernel:  domain 0: span 3
Mar 23 12:04:25 zero kernel:   groups: 1 2
Mar 23 12:04:25 zero kernel: CPU1 attaching sched-domain:
Mar 23 12:04:25 zero kernel:  domain 0: span 3
Mar 23 12:04:25 zero kernel:   groups: 2 1

I don't know how the scheduling domains work, and i'm too busy to look it up
right now.

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0x15741ECE
