Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314242AbSDVQId>; Mon, 22 Apr 2002 12:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314244AbSDVQIc>; Mon, 22 Apr 2002 12:08:32 -0400
Received: from [195.39.17.254] ([195.39.17.254]:38542 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S314242AbSDVQIa>;
	Mon, 22 Apr 2002 12:08:30 -0400
Date: Sun, 21 Apr 2002 18:57:05 +0000
From: Pavel Machek <pavel@suse.cz>
To: Robert Love <rml@tech9.net>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8: preemption + SMP broken ?
Message-ID: <20020421185705.B155@toy.ucw.cz>
In-Reply-To: <20020417232253.A629@in.ibm.com> <1019067957.1669.46.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > My machine (4cpu x86) hangs while booting a kernel with SMP
> > and preemption enabled. It hangs while executing one of
> > the initcalls, probably BIO since that is where the
> > next boot message comes from during a successful boot with SMP
> > (or preemption) disabled.
> > 
> > Has anyone tried out preemption with SMP ?
> 
> Sure, all my testing is on SMP.  The problem manifested itself in
> 2.5.8-pre when some changes where made to the migration code.  The race
> is in the migration code - I am not sure it is preempts fault, per se,
> but the attached patch should fix it.  It is pending with Linus for the
> next release.

Wel, if race is in migration code, you should fix migration, not add
preempt_disable(), right? [Or is race preempt-onlly?]

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

