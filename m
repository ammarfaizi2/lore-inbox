Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRK0MVC>; Tue, 27 Nov 2001 07:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277532AbRK0MUw>; Tue, 27 Nov 2001 07:20:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45286 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S277514AbRK0MUo>;
	Tue, 27 Nov 2001 07:20:44 -0500
Date: Tue, 27 Nov 2001 15:17:43 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Robert Love <rml@tech9.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc-based cpu affinity user interface
In-Reply-To: <Pine.LNX.4.40.0111261948460.1674-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0111271459400.14344-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Nov 2001, Davide Libenzi wrote:

> As I said in reply to Ingo patch, it'd be better to expose "number"
> cpu masks not "logical" ( like cpus_allowed ). In this way the users
> can use 0..N-1 ( N == number of cpus phisically available ) w/out
> having to know the internal mapping between logical and number ids.

yep, agreed. I've uploaded a new set-affinity syscall patch with your
improvement added:

	http://redhat.com/~mingo/set-affinity-patches/set-affinity-2.4.16-A0

i've only tested it on x86 which has a 1:1 mapping between physical and
logical CPUs, but it should be fine on other architectures as well.

	Ingo

