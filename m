Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269286AbUJVXfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269286AbUJVXfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 19:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269233AbUJVXc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 19:32:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59354 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269259AbUJVXc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 19:32:29 -0400
Subject: Re: How is user space notified of CPU speed changes?
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, "Jack O'Quin" <joq@io.com>
In-Reply-To: <4179623C.9050807@nortelnetworks.com>
References: <1098399709.4131.23.camel@krustophenia.net>
	 <1098444170.19459.7.camel@localhost.localdomain>
	 <1098468316.5580.18.camel@krustophenia.net>
	 <4179623C.9050807@nortelnetworks.com>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 19:25:58 -0400
Message-Id: <1098487558.1440.20.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 13:40 -0600, Chris Friesen wrote:
> Lee Revell wrote:
> 
> > Seems like you are implying that any userspace app that needs to know
> > the CPU speed is broken.  Is this correct?
> 
> No, we're saying that Intel's tsc implementation is broken.  <grin>
> 
> x86 really could use an on-die register that increments at 1GHz independent of 
> clock speed and is synchronized across all CPUs in an SMP box.

Like this? (posted to jackit-devel):

On Fri, 2004-10-22 at 18:20 -0500, Jack O'Quin wrote: 

> On PowerPC, JACK uses the lower half of the 64-bit Timebase register,
> which is accessible from user mode.  This is better then the i386
> cycle counter, I believe.  See: `config/cpu/powerpc/cycles.h', the
> comment about only using it for SMP is bogus.  We use this for both
> MacOS X and Linux.

-- 
Lee Revell <rlrevell@joe-job.com>

