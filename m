Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVBFGXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVBFGXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 01:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264436AbVBFGXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 01:23:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:57570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272661AbVBFGXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 01:23:09 -0500
Date: Sat, 5 Feb 2005 22:23:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: laurent.riffard@free.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 : mount UDF CDRW stuck in D state
Message-Id: <20050205222301.337de629.akpm@osdl.org>
In-Reply-To: <m3sm4apig8.fsf@telia.com>
References: <4204F91B.5040302@free.fr>
	<m3vf96r017.fsf@telia.com>
	<m3sm4apig8.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> Peter Osterlund <petero2@telia.com> writes:
> 
> > Laurent Riffard <laurent.riffard@free.fr> writes:
> > 
> > > This is kernel 2.6.11-rc3-mm1. I can't mount an UDF-formatted cdrw
> > > in packet-writing mode. Mount process gets stuck in D state.
> > > 
> > > Mounting and writing this media in packet-writing mode works fine
> > > with kernel 2.6.11-rc2-mm2.
> > 
> > I tried to repeat the problem, but I didn't get far, because I get a
> > kernel panic right after init is started:
> 
> I got around that by disabling preempt, radeon framebuffer, HPET
> timer, APIC. Don't know which one caused the panic, will track it down
> later.

Please do - the above combo works for me (as usual).  I don't recall anyone
else reporting it.

> Anyway, mount hangs for me too if I use an IDE drive, both with native
> ide and ide-scsi emulation. It doesn't hang with a USB drive though. I
> verified that 2.6.11-rc3 does not have this problem. Reverting
> bk-ide-dev does *not* fix the problem.

Bah.  sysrq-T output would be helpful.

