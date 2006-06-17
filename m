Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751538AbWFQFMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbWFQFMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 01:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWFQFMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 01:12:30 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7821 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751536AbWFQFMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 01:12:30 -0400
Date: Sat, 17 Jun 2006 14:12:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ak@suse.de, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] avoid cpu hot remove of cpus which have special RT
 tasks.
Message-Id: <20060617141216.dba310af.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <44937B16.3050204@yahoo.com.au>
References: <20060616162343.02c3ce62.kamezawa.hiroyu@jp.fujitsu.com>
	<p7364j1qx66.fsf@verdi.suse.de>
	<20060616192654.50f4f6b7.kamezawa.hiroyu@jp.fujitsu.com>
	<200606161236.50302.ak@suse.de>
	<44937B16.3050204@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jun 2006 13:46:30 +1000
Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > If its CPU fails much worse things than that will happen.
> > 
> > One way might be to break affinity of all processes in the system on hot unplug
> > - then your deadlock would be avoided - but it might be a bit radical.
> 
> Agreed. The kernel is just doing some basic fallback behaviour. If you
> actually have a critical RT system, you probably need to have much more
> sophisticated handling of CPU unplug anyway. So it doesn't make much
> sense to complicate the kernel for this.
> 
But it seems the kernel does what users doesn't want.
threads which is tightly coupled to some cpu has some important meanings for
the userk.
If the apps are sophisticated as you say, cpus_allowed containes other cpus
before hotplug. As SIGSTOP/KILL patch I posted, the apps shouldn't do unexpected
work, I think.

-Kame

