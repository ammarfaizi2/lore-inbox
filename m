Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262665AbSKDSsJ>; Mon, 4 Nov 2002 13:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262664AbSKDSsI>; Mon, 4 Nov 2002 13:48:08 -0500
Received: from web20504.mail.yahoo.com ([216.136.226.139]:27706 "HELO
	web20504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262665AbSKDSsC>; Mon, 4 Nov 2002 13:48:02 -0500
Message-ID: <20021104185435.11019.qmail@web20504.mail.yahoo.com>
Date: Mon, 4 Nov 2002 10:54:35 -0800 (PST)
From: vasya vasyaev <vasya197@yahoo.com>
Subject: Re: Machine's high load when HIGHMEM is enabled
To: linux-kernel@vger.kernel.org
In-Reply-To: <3DC5337C.4090506@quark.didntduck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

First of all - thanks to these people, who responded
to my question.

I have some news...

I've tried kernels:
2.4.19 - the same result
2.5.44 - the same result
2.5.45 - the same result

If I take 1 Gb of memory away, then computer works
much better, faster (something like without enabled
HIGHMEM at all).
The same effect takes place if I say mem=1024M while
physically box has 2Gb of RAM - everything is fine!
But if I start HIGHMEM enabled kernel on this box (2Gb
RAM), then it works too slowly...


The questions are:
1. is there anyone on the list, who has the same or
near configuration ? (main is that the box has >=2Gb
of RAM)
2. do you experience the same problems ?
3. maybe it's not a problem at all?!? I mean maybe
linux kernel works this way with such amount of memory
and there is no problem with that?
4. the case I've described =
http://www.cs.helsinki.fi/linux/linux-kernel/2001-02/0292.html
?

and finally, if this could be solved - please tell,
how should I set up the kernel/kernel settings to get
appropriate results in performance ?


Thank you.


--- Brian Gerst <bgerst@quark.didntduck.org> wrote:
> 2.4 can only do I/O to and from lowmem.  This means
> highmem pages have 
> to use bounce buffers in lowmem, and th edata is
> copied to/from highmem 
> which is causing the cpu load.  This has been
> corrected in 2.5, which 
> can do I/O to any page the device can DMA from.


__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/
