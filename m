Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTEGOew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbTEGOev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:34:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53634 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263381AbTEGOeu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:34:50 -0400
Date: Wed, 7 May 2003 10:49:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Torsten Landschoff <torsten@debian.org>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.69
In-Reply-To: <20030507143315.GA6879@stargate.galaxy>
Message-ID: <Pine.LNX.4.53.0305071044550.12156@chaos>
References: <20030507132024.GB18177@wohnheim.fh-wedel.de>
 <Pine.LNX.4.53.0305070933450.11740@chaos> <20030507135657.GC18177@wohnheim.fh-wedel.de>
 <20030507143315.GA6879@stargate.galaxy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, Torsten Landschoff wrote:

> On Wed, May 07, 2003 at 03:56:57PM +0200, Jörn Engel wrote:
> > Agreed, partially. There is the current issue of the kernel stack
> > being just 8k in size and no decent mechanism in place to detect a
> > stack overflow. And there is (arguably) the future issue of the kernel
> > stack shrinking to 4k.
>
> Pardon my ignorance, but why is the kernel stack shrinked to just a few
> kilobytes? With 256MB of RAM in a typical desktop system it shouldn't
> be a problem to use 256KB from that as the stack, but I am sure there
> are good reasons to shrink it.
>
> Just curious, thanks for any info
>
> 	Torsten
>
> PS: Joern, you don't by chance know my sister (kirsten@wh.fh-wedel.de)??
> :-))
>

An x86 'page' is 0x1000. For a kernel stack, this must be always
resident. The next possible size would be 0x2000, etc. If it can
be kept under 0x1000, then remaining fixed pagers can be used for
those dynamically-allocated network-packet buffers, etc.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

