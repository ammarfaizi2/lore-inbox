Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288603AbSAHX7j>; Tue, 8 Jan 2002 18:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288604AbSAHX73>; Tue, 8 Jan 2002 18:59:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14089 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288603AbSAHX7S>; Tue, 8 Jan 2002 18:59:18 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: brownfld@irridia.com (Ken Brownfield)
Date: Wed, 9 Jan 2002 00:10:38 +0000 (GMT)
Cc: kernel@Expansa.sns.it (Luigi Genoni), linux-kernel@vger.kernel.org
In-Reply-To: <20020108173254.B9318@asooo.flowerfire.com> from "Ken Brownfield" at Jan 08, 2002 05:32:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16O6KE-00087x-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Preemptive gives better interactivity under load, which is the whole
> point of multitasking (think about it).  If you don't want the overhead
> (which also exists without preemptive) run #processes == #processors.

That is generally not true. Pe-emption is used in user space to prevent
applications doing very stupid things. Pre-emption in a trusted environment
can often be most efficient if done by the programs themselves.

Userspace is not a trusted environment

> I'm really surprised that people are still actually arguing _against_
> preemptive multitasking in this day and age.  This is a no-brainer in
> the long run, where current corner cases aren't holding us back.

Andrew's patches give you 1mS worst case latency for normal situations, that
is below human perception, and below scheduling granularity. In other words
without the efficiency loss and the debugging problems you can place the
far enough latency below other effects that it isnt worth attacking any more.

Alan
