Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264063AbVBFBsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264063AbVBFBsw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264032AbVBFBsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:48:51 -0500
Received: from av3-2-sn1.fre.skanova.net ([81.228.11.110]:40357 "EHLO
	av3-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S272647AbVBFBsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 20:48:10 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc3-mm1 : mount UDF CDRW stuck in D state
References: <4204F91B.5040302@free.fr> <m3vf96r017.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 06 Feb 2005 02:48:07 +0100
In-Reply-To: <m3vf96r017.fsf@telia.com>
Message-ID: <m3sm4apig8.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Laurent Riffard <laurent.riffard@free.fr> writes:
> 
> > This is kernel 2.6.11-rc3-mm1. I can't mount an UDF-formatted cdrw
> > in packet-writing mode. Mount process gets stuck in D state.
> > 
> > Mounting and writing this media in packet-writing mode works fine
> > with kernel 2.6.11-rc2-mm2.
> 
> I tried to repeat the problem, but I didn't get far, because I get a
> kernel panic right after init is started:

I got around that by disabling preempt, radeon framebuffer, HPET
timer, APIC. Don't know which one caused the panic, will track it down
later.

Anyway, mount hangs for me too if I use an IDE drive, both with native
ide and ide-scsi emulation. It doesn't hang with a USB drive though. I
verified that 2.6.11-rc3 does not have this problem. Reverting
bk-ide-dev does *not* fix the problem.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
