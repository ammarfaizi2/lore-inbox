Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317778AbSFMQi1>; Thu, 13 Jun 2002 12:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSFMQi0>; Thu, 13 Jun 2002 12:38:26 -0400
Received: from gra-vd1.iram.es ([150.214.224.250]:29327 "EHLO gra-vd1.iram.es")
	by vger.kernel.org with ESMTP id <S317778AbSFMQiZ>;
	Thu, 13 Jun 2002 12:38:25 -0400
Message-ID: <3D08CA7E.9050704@iram.es>
Date: Thu, 13 Jun 2002 18:38:22 +0200
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.5) Gecko/20011016
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Futex Asynchronous Interface
In-Reply-To: <3D0776EE.4040701@loewe-komp.de> <Pine.LNX.4.44.0206120946100.22189-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Right now the kernel does _zero_ work for a lock that isn't contended. It
> doesn't know _anything_ about the process that got the lock initially.
> 
> Any amount of tracking would be _extremely_ expensive. Right now getting
> an uncontended lock is about 15 CPU cycles in user space.
> 
> Tryin to tell the kernel about gettign that lock takes about 1us on a P4
> (system call overhead), ie we're talking 18000 cycles. 18 THOUSAND cycles
> minimum. Compared to the current 15 cycles. That's more than three orders
> of magnitude slower than the current code, and you just lost the whole
> point of doing this all in user space in the first place.


Please tell us where you got your 18GHz CPU (18000 cycles/microsecond) ;-)

I want one, badly!

	Gabriel

