Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWH0RWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWH0RWG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 13:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWH0RWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 13:22:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51102 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932195AbWH0RWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 13:22:03 -0400
Date: Sun, 27 Aug 2006 10:21:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-Id: <20060827102116.f9077bac.akpm@osdl.org>
In-Reply-To: <20060827110657.GF22565@in.ibm.com>
References: <20060824102618.GA2395@in.ibm.com>
	<20060824091704.cae2933c.akpm@osdl.org>
	<20060825095008.GC22293@redhat.com>
	<Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
	<20060826150422.a1d492a7.akpm@osdl.org>
	<20060827061155.GC22565@in.ibm.com>
	<20060826234618.b9b2535a.akpm@osdl.org>
	<20060827071116.GD22565@in.ibm.com>
	<20060827004213.4479e0df.akpm@osdl.org>
	<20060827110657.GF22565@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 16:36:58 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> > Did you look?  workqueue_mutex is used to protect per-cpu workqueue
> > resources.  The lock is taken prior to modification of per-cpu resources
> > and is released after their modification.  Very very simple.
> 
> I did and there is no lock named workqueue_mutex. workqueue_cpu_callback()
> is farily simple and doesn't have the issues in cpufreq that
> we are talking about (lock_cpu_hotplug() in cpu callback path).

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b41ea7289a589993d3daabc61f999b4147872c4
