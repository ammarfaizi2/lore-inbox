Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSLVKIw>; Sun, 22 Dec 2002 05:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSLVKIw>; Sun, 22 Dec 2002 05:08:52 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20353 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S264919AbSLVKIw>;
	Sun, 22 Dec 2002 05:08:52 -0500
Date: Sun, 22 Dec 2002 11:23:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212211858240.8783-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212221114490.31068-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


while reviewing the sysenter trampoline code i started wondering about the
HT case. Dont HT boxes share the MSRs between logical CPUs? This pretty
much breaks the concept of per-logical-CPU sysenter trampolines. It also
makes context-switch time sysenter MSR writing impossible, so i really
hope this is not the case.

	Ingo




