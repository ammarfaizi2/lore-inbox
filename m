Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbQKBFZg>; Thu, 2 Nov 2000 00:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130459AbQKBFZ1>; Thu, 2 Nov 2000 00:25:27 -0500
Received: from www.wen-online.de ([212.223.88.39]:65285 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130439AbQKBFZT>;
	Thu, 2 Nov 2000 00:25:19 -0500
Date: Thu, 2 Nov 2000 06:25:21 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Pieter van Prooijen <pprooi@xs4all.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.0-test10 locks up during kernel compiles on Toshiba
 CDT  1640
In-Reply-To: <3A009557.135DF15E@xs4all.nl>
Message-ID: <Pine.Linu.4.10.10011020613270.1061-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Pieter van Prooijen wrote:

> Content-Type: text/plain; charset=us-ascii
> Content-Transfer-Encoding: 7bit
> 
> Hi,
> 
> During kernel compilation (or other heavy use of the machine), the
> machine
> locks up. No oops, no alt-sysreq, only a hardware reset is
> possible. 
> 
> Machine is a Toshiba CDT 1640 laptop: 475 MHz K6-II+, 128KB cache, 64 MB
> ram, Aladdin V chipset, 6 GB Fujitsu hd.
> 
> Observations:
> 
> The standard RedHat kernel (2.2.16) and Windows work fine, so it doesn't
> seem to be a hardware problem.

Except likely it is hardware.. the plastic case :)

> When the machine locks up, the little fan begins running immediately,
> which means the processor is getting very hot (doing what ?)

Compiling is very cpu intensive, so the system won't be doing many
idle calls (where cpu can cool down).  This sounds like your cpu is
having a heatstroke and shutting down instead of frying itself.

It may well be that 2.4 kernel is keeping the cpu busy more than 2.2
or windows does, and your box is poorly designed wrt heat disipation.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
