Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268101AbTBMR5R>; Thu, 13 Feb 2003 12:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268102AbTBMR5R>; Thu, 13 Feb 2003 12:57:17 -0500
Received: from ns.suse.de ([213.95.15.193]:54537 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268101AbTBMR5P>;
	Thu, 13 Feb 2003 12:57:15 -0500
Date: Thu, 13 Feb 2003 19:07:05 +0100
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030213180705.GB27560@wotan.suse.de>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk> <20030212075048.GA9049@wotan.suse.de> <20030212102741.GC10422@bjl1.jlokier.co.uk> <20030212104508.GA1273@wotan.suse.de> <m1of5gwyhq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1of5gwyhq.fsf@frodo.biederman.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Hmm, this is becomming a FAQ]

> Switching in and out of long mode is evil enough that I don't think it
> is worth it.  And encouraging people to write good JIT compiling

Forget it. It is completely undefined in the architecture what happens
then. You'll lose interrupts and everything. Nothing for an operating
system intended to be stable.

I have no plans at all to even think about it for Linux/x86-64.

> emulators sounds much better, especially in the long run.  But it can
> be written.

For DOS even a slow emulator should be good enough. After all most
DOS Programs are written for slow machines. Bochs running on a K8
will be hopefully fast enough. If not an JIT can be written, perhaps
you can extend valgrind for it.

Or if you really rely on a DOS program executing fast you can
always boot a 32bit kernel which of course still supports vm86
in legacy mode.

-Andi
