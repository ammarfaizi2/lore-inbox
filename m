Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSLMIbi>; Fri, 13 Dec 2002 03:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSLMIbi>; Fri, 13 Dec 2002 03:31:38 -0500
Received: from mail.webmaster.com ([216.152.64.131]:57850 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S261550AbSLMIbh> convert rfc822-to-8bit; Fri, 13 Dec 2002 03:31:37 -0500
From: David Schwartz <davids@webmaster.com>
To: <mcmanus@ducksong.com>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 13 Dec 2002 00:39:27 -0800
In-Reply-To: <20021211235258.GA10857@ducksong.com>
Subject: Re: Memory Measurements and Lots of Files and Inodes
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021213083926.AAA29353@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Can anybody provide a better metric for "ram free for userspace
>allocations"?

	This is a constant battle for programmers trying to develop sophisticated 
applications for sophisticated operating systems.

	If all of the applications are cooperating, you can do it fairly easily. 
First, ask the kernel how much physical memory there is. Then fudge a 
reduction based on kernel usage. Then subtract the amount of RAM each 
application is 'really using' by asking it.

	If you write all the applications, this isn't hard to do. If you have to 
cooperate with other applications you didn't write, things get trickier. If 
you're the only application, things are really easy.

	There are any number of heuristics and guesstimates. Ultimately, I recommend 
mostly leaving your memory usage user-configurable.

	DS


