Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWISQcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWISQcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWISQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:32:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15812 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932314AbWISQcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:32:23 -0400
Subject: Re: [PATCH] Migration of Standard Timers
From: Lee Revell <rlrevell@joe-job.com>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Jes Sorensen <jes@sgi.com>
In-Reply-To: <20060919152942.GA26863@sgi.com>
References: <20060919152942.GA26863@sgi.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 12:33:37 -0400
Message-Id: <1158683617.11682.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 10:29 -0500, Dimitri Sivanich wrote:
> This patch allows the user to migrate currently queued
> standard timers from one cpu to another.  Migrating
> timers off of select cpus allows those cpus to run
> time critical threads with minimal timer induced latency
> (which can reach 100's of usec for a single timer as shown
> on an X86_64 test machine), thereby improving overall
> determinance on those selected cpus. 

Which driver or subsystem is doing 100s of usecs of work in a timer?
Shouldn't another mechanism like a workqueue be used instead?

Lee

