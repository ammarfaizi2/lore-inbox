Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSEVAJH>; Tue, 21 May 2002 20:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSEVAJG>; Tue, 21 May 2002 20:09:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25872 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316794AbSEVAJF>; Tue, 21 May 2002 20:09:05 -0400
Date: Tue, 21 May 2002 17:09:11 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <20020521233312.GA27021@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0205211707001.3589-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Pavel Machek wrote:
>
> I need to know more than they are sleeping. I also know they are
> sleeping *without holding any semaphores*. I need working system to be
> able to save state to disk. That's why I hacked it into signal
> handler.

Sorry, I should have been more clear. I think the signal handler approach
is fine for user processes, I was just wondering why you needed anything
like that for kernel threads..

When a kernel thread is sleeping, I don't see that it has much state at
all: it will be re-started anyway on the next boot, and I don't see it
having any "state".

(I didn't think it through enough - never mind saving the stack page,
because I don't think there is anything at all interesting there to save).

		Linus

