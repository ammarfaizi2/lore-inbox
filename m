Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263979AbUGZQyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263979AbUGZQyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 12:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGZQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 12:54:38 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:46977 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264430AbUGZPnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 11:43:15 -0400
Date: Mon, 26 Jul 2004 17:43:12 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: preempt timing violations (unmap_vmas)
Message-ID: <20040726154312.GA28607@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Lee Revell <rlrevell@joe-job.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1090813907.6936.56.camel@mindpipe> <20040726085002.GA25519@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726085002.GA25519@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

> > 2ms non-preemptible critical section violated 1 ms preempt threshold
> > starting at unmap_vmas+0x1ff/0x210 and ending at
> > unmap_vmas+0x1f5/0x210
> 
> this is the normal sys_exit()->exit_mmap()->unmap_vmas() path. It's
> weird that it generated a 2ms latency. What are the values of
> voluntary_preemption and kernel_preemption on your current kernel? With
> a 2:0 setting we ought to have a reschedule point every 32 pages.  Do
> you know which application triggers this latency and is it easy to
> reproduce?

I discovered that I got two of these in a row. The settings are 2:1, but I am
not able to reproduce it.

Rudo.
