Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbRFTPYY>; Wed, 20 Jun 2001 11:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264902AbRFTPYS>; Wed, 20 Jun 2001 11:24:18 -0400
Received: from copland.udel.edu ([128.175.13.92]:1023 "EHLO copland.udel.edu")
	by vger.kernel.org with ESMTP id <S264901AbRFTPYC>;
	Wed, 20 Jun 2001 11:24:02 -0400
Date: Wed, 20 Jun 2001 10:35:31 -0400 (EDT)
From: Mike Porter <mike@UDel.Edu>
To: bert hubert <ahu@ds9a.nl>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <20010619211038.A3704@home.ds9a.nl>
Message-ID: <Pine.SOL.4.31.0106201027220.17484-100000@copland.udel.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But that foregoes the point that the code is far more complex and harder to
> make 'obviously correct', a concept that *does* translate well to userspace.

One point is that 'obviously correct' is much harder to 'prove' for
threads (or processes with shared memory) than you might think.
With a state machine, you can 'prove' that object accesses won't
conflict much more easily.  With a threaded or process based model,
you have to spend considerable time thinking about multiple readers
and writers and locking.

One metric I use to evaluate program complexity is how big of a
headache I get when trying to prove something "correct".
Multi-process or multi-threaded code hurts more than a well written
state machine.

Mike

