Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSFQQHz>; Mon, 17 Jun 2002 12:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFQQHy>; Mon, 17 Jun 2002 12:07:54 -0400
Received: from Morgoth.esiway.net ([193.194.16.157]:65038 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S313767AbSFQQHy>; Mon, 17 Jun 2002 12:07:54 -0400
Date: Mon, 17 Jun 2002 18:07:51 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: Roberto Fichera <kernel@tekno-soft.it>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       David Schwartz <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Developing multi-threading applications
In-Reply-To: <5.1.1.6.0.20020617094803.00a96bd0@mail.tekno-soft.it>
Message-ID: <Pine.LNX.4.44.0206171755340.1449-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Roberto Fichera wrote:

[...]
> process to a CPU. But I continue to not hunderstand why
> I must have only one thread per CPU. There is some URL
> where can I see some kernel/sched/vm/I-O/other-think graph about
> this point ?

To put it simply, because you have only one PC per CPU. It's not
really an OS thing.

Every time you're saving the PC (and SP, and all the "thread context")
you're "emulating" more CPUs on just one. And what you got is just...
an emulation. A Thread is an execution abstraction, and a CPU is an
execution actor. Sounds sensible to match the two. Use functions instead
to group instructions by their (functional) meaning.

It makes much more sense, on 4-ways system, to have 4 rather complex
threads that are able to execute different functions, like in
a data-driven or event-driven model, than to run 400 simpler threads
which implement one function each, IMHO.

.TM.


