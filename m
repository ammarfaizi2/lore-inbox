Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284831AbRLZUN0>; Wed, 26 Dec 2001 15:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284836AbRLZUNQ>; Wed, 26 Dec 2001 15:13:16 -0500
Received: from ns01.netrox.net ([64.118.231.130]:15766 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S284831AbRLZUNC>;
	Wed, 26 Dec 2001 15:13:02 -0500
Subject: Re: [PATCH] fully preemptible kernel
From: Robert Love <rml@tech9.net>
To: Steve Bergman <steve@rueb.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1009396922.1678.9.camel@voyager.rueb.com>
In-Reply-To: <1007930466.11789.2.camel@phantasy> 
	<1009396922.1678.9.camel@voyager.rueb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 26 Dec 2001 15:13:50 -0500
Message-Id: <1009397641.4966.5.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-12-26 at 15:02, Steve Bergman wrote:

> I just compiled 2.4.17 with the patch from your site that looks to be
> for 2.4.17-final.  Unfortunately, several modules (e.g. unix.o) fail on
> load with an undefined symbol error (preempt_schedule).  FWIW, I also
> have the patch that started the recent "Make highly niced processes run
> only when idle" thread.  Which reminds me, I'm anxious to try out your
> "fixed" version of SCHED_IDLE when it's ready. ;-) 

If there is no compile error, it is probably mismatched modules, because
preempt_schedule is properly exported.

Make sure your kernel tree is fully patched and CONFIG_PREEMPT is
enabled.  Rerun `make dep' and then recompile (including your modules). 
Make sure your modules are properly installed.

Either your running kernel doesn't have preemption enabled or your
kernel does but your modules don't (i.e. they are old modules).

	Robert Love

