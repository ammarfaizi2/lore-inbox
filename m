Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262619AbRE3Fyw>; Wed, 30 May 2001 01:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRE3Fym>; Wed, 30 May 2001 01:54:42 -0400
Received: from chiara.elte.hu ([157.181.150.200]:55050 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262619AbRE3Fye>;
	Wed, 30 May 2001 01:54:34 -0400
Date: Wed, 30 May 2001 07:51:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Emulate RDTSC
In-Reply-To: <025801c0e8a6$8e57ae60$bba6b3d0@Toshiba>
Message-ID: <Pine.LNX.4.33.0105300750170.1462-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 May 2001, Jaswinder Singh wrote:

> What is the nice way (in accuracy and performance) to emulate RDTSC in
> Linux for those architectures who dont support RDTSC like in Hitachi
> SH Processors.

if the hardware provides no way to get some accurate estimation of current
time, then there is no way to solve this problem in a generic way.
Typically there are some cycle-accuracy counters in the CPU (ideal
situation), or sometimes there is a counter in some external device (eg.
the i8254 timer counter), but access to these tend to be slow and
typically they are quite coarse as well.

	Ingo

