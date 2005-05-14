Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVENPZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVENPZY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 11:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVENPZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 11:25:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51409 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261387AbVENPZT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 11:25:19 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>, Andi Kleen <ak@muc.de>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
In-Reply-To: <1116027488.6380.55.camel@mindpipe>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1116084186.20545.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 May 2005 16:23:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-05-14 at 00:38, Lee Revell wrote:
> Well yes but you would still have to recompile those apps.  And take the
> big performance hit from using gettimeofday vs rdtsc.  Disabling HT by
> default looks pretty good by comparison.

You cannot use rdtsc for anything but rough instruction timing. The
timers for different processors run at different speeds on some SMP
systems, the timer rates vary as processors change clock rate nowdays.
Rdtsc may also jump dramatically on a suspend/resume.

If the app uses rdtsc then generally speaking its terminally broken. The
only exception is some profiling tools.

