Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966487AbWKNXnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966487AbWKNXnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966489AbWKNXnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:43:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26540 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S966487AbWKNXnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:43:51 -0500
Date: Wed, 15 Nov 2006 00:43:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061114234334.GB3394@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz> <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> I don't have a configuration I can test this but it compiles cleanly
> >
> > Ugh, now that's a big patch.. and untested, too :-(.
> 
> It was very carefully code reviewed at least the first time,
> and the code was put in sync with code that was tested.

So we had two very different versions of "switch to 64-bit" and now we
have two mostly similar versions. Not a big improvement...

> > Why is PGE no longer required, for example?
> 
> PGE is never required.  Especially on a temporary page table.
> PGE is an optimization, to make context switches faster.

HPA tells me it is.

> > Can we get it piece-by-piece?

Please?

> >> Vivek has tested this patch for suspend to memory and it works fine.
> >
> > Ok, so it was tested on one config. Given that the patch deals with
> > detecting CPU oddities... :-(
> 
> Read the code.  Given your scorn and the state of that mess when I
> started I'm not certain a productive conversation can be had.
> 
> Do you understand the code as it is currently written?

Mostly. I've written it at some point.

It may be a mess, but patch below is wholesale rewrite, mixing
cleanups (ebx->rbx) with serious changes (PGE). And then you tell me
it was tested on one machine. It is hard/impossible to rewrite, and
changelog is not helpful, either.

Please split it up.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
