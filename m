Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbSLQTtk>; Tue, 17 Dec 2002 14:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSLQTtk>; Tue, 17 Dec 2002 14:49:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55560 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265787AbSLQTtj>; Tue, 17 Dec 2002 14:49:39 -0500
Date: Tue, 17 Dec 2002 11:58:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.3.95.1021217144308.26554A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0212171157050.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Richard B. Johnson wrote:
>
> You can call intersegment with a full pointer. I don't know how
> expensive that is.

It's so expensive as to not be worth it, it's cheaper to load a register
or something, i eyou can do

	pushl $0xfffff000
	call *(%esp)

faster than doing a far call.

		Linus

