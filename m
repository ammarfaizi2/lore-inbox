Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWFRV7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWFRV7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 17:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWFRV7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 17:59:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:64179 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932091AbWFRV7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 17:59:16 -0400
Date: Sun, 18 Jun 2006 18:46:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ashok.raj@intel.com
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT tasks.
Message-ID: <20060618164654.GA826@openzaurus.ucw.cz>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When cpu hot remove happens, tasks on the target cpu will be migrated even if
> no available cpus in tsk->cpus_allowed. (See: move_task_off_dead_cpu().)
> 
> Usually, it looks ok (I think not good but may be ok.) But forced migration
> should be avoided if there is RT task which is designed to run only on
> specified cpu.

That would break software suspend, sorry.

NAK.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

