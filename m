Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751843AbWFVRVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbWFVRVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWFVRVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:21:45 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:49627 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751404AbWFVRVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:21:45 -0400
Date: Fri, 23 Jun 2006 02:20:56 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: rdunlap@xenotime.net, clameter@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-Id: <20060623022056.5d561d68.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060622170431.GM16029@localdomain>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
	<20060621225609.db34df34.akpm@osdl.org>
	<20060622150848.GL16029@localdomain>
	<20060622084513.4717835e.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
	<20060623010550.0e26a46e.kamezawa.hiroyu@jp.fujitsu.com>
	<20060622092422.256d6692.rdunlap@xenotime.net>
	<20060622170431.GM16029@localdomain>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 12:04:31 -0500
Nathan Lynch <ntl@pobox.com> wrote:

> Randy.Dunlap wrote:
> > Sounds like we are getting nowhere.  The sysctl knob might
> > have to be the answer.
> 
> I don't like having the kernel forcibly kill or stop tasks for this
> case, regardless of whether the behavior is configurable.  What I
> originally meant to suggest was a sysctl knob which will control
> whether the offline will fail in this situation. 
Okay, stop_on_cpu_lost patcfh is not good anyway.
Andrew, could you drop stop_on_cpu_lost patch ?

>From this discussion, it seems there is a direction. 
I'll update my avoid_cpu_removal_if_busy patch and add sysctl for it.

> But I'm still more inclined to leave the kernel's handling of this as it
> stands, since this is policy that can be implemented in userspace.
> 
A program to walk through all tasks and check thier allowd_cpus ?

> We need to preserve the current behavior as the default, in any case.
> 
I agree here.

-Kame

