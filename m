Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbVLHFdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbVLHFdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbVLHFdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:33:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38827 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030462AbVLHFdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:33:07 -0500
Date: Thu, 8 Dec 2005 00:33:02 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208053302.GA28201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208052632.GF11190@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 06:26:32AM +0100, Andi Kleen wrote:

Hi Andi,

 > > Whilst debugging a memory leak, I hit sysrq meminfo,
 > > and got hot/cold info for CONFIG_NR_CPUS rather than 4 cpus
 > > 
 > > I've only tried reproducing this on x86-64 so far.
 > 
 > If the online map is wrong all kinds of things would go wrong.
 > 
 > Most likely your kernel doesn't have the fix.

This was seen with a .15rc5-git1 kernel.
Is this something still living in your x86-64 patchset or -mm ?
 
 > The possible map is fixed kind of BTW in 2.6.15rc*. It was a side effect
 > of CPU hotplug, which now uses a better algorithm to guess the 
 > number of possible CPUs. In 2.6.15 you will just get half the number
 > of available CPUs in addition by default

Yep, I noticed it offers a maximum of 6 cpus on my way.
As a sidenote, seems kinda funny (and wasteful maybe?), doing this
on a lot of hardware that isn't hotplug capable. (Whilst I could
disable cpu hotplug in my local build, this isn't an answer for
a generic distro kernel).

		Dave

