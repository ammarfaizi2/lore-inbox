Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282894AbRK0J41>; Tue, 27 Nov 2001 04:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282893AbRK0JzK>; Tue, 27 Nov 2001 04:55:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:35557 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S282892AbRK0Jym>;
	Tue, 27 Nov 2001 04:54:42 -0500
Date: Tue, 27 Nov 2001 12:52:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <1006831902.842.0.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0111271247120.9992-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 Nov 2001, Robert Love wrote:

> Attached is my procfs-based implementation of a user interface for
> getting and setting a task's CPU affinity.  Patch is against 2.4.16.

two comments. First, this has already been done - Andrew Morton has
written such a patch.

Second, as i've repeatedly said it, it's a failure to do this over /proc.
What if /proc is not mounted? What if the process is in a chroot()
environment, should it not be able to set its own affinity? This is a
fundamental limitation of your approach, and *if* we want to export the
cpus_allowed affinity to user-space (which is up to discussion), then the
right way (TM) to do it is via a syscall.

	Ingo

