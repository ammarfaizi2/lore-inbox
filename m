Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUCRDkb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 22:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUCRDkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 22:40:31 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29635 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262286AbUCRDk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 22:40:28 -0500
Date: Wed, 17 Mar 2004 22:40:31 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: Kenneth Chen <kenneth.w.chen@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org,
       CPU Freq ML <cpufreq@www.linux.org.uk>
Subject: Re: add lowpower_idle sysctl
In-Reply-To: <20040317192821.1fe90f24.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0403172237470.28447@montezuma.fsmlabs.com>
References: <20040317170436.430acfbe.akpm@osdl.org>
 <200403180318.i2I3IDF03166@unix-os.sc.intel.com> <20040317192821.1fe90f24.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2004, Andrew Morton wrote:

> "Kenneth Chen" <kenneth.w.chen@intel.com> wrote:
> >
> >  > > Logically it means a sysctl entry in /proc/sys/kernel.
> >  > Yes, but the *meanings* of the different values of that sysctl need
> >  > to be defined, and documented.  If lowpower_idle=42 has a totally
> >  > different meaning on different architectures then that's unfortunate
> >  > but understandable.  But we should at least enumerate the different
> >  > values and try to get different architectures to honour `42' in the
> >  > same way.
> >
> >  Writing to sysctl should be a bool, reading the value can be number of
> >  module currently disabled low power idle.  I think the original intent
> >  is to use ref count for enabling/disabling.  (granted, we copied the
> >  code from other arch).
>
> OK, so why not give us:
>
> #define IDLE_HALT			0
> #define IDLE_POLL			1
> #define IDLE_SUPER_LOW_POWER_HALT	2
>
> and so forth (are there any others?).
>
> Set some system-wide integer via a sysctl and let the particular
> architecture decide how best to implement the currently-selected idle mode?

I'm wondering whether the setting of these magic numbers can't be done
using cpufreq infrastructure.

