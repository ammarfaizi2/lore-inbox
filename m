Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268879AbTBZTyx>; Wed, 26 Feb 2003 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268885AbTBZTyx>; Wed, 26 Feb 2003 14:54:53 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:13710 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268879AbTBZTyw> convert rfc822-to-8bit; Wed, 26 Feb 2003 14:54:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: VM problems in 2.4.20
Date: Wed, 26 Feb 2003 21:04:52 +0100
User-Agent: KMail/1.4.3
References: <20030226194043.GA14293@flounder.net>
In-Reply-To: <20030226194043.GA14293@flounder.net>
Cc: Adam McKenna <adam@flounder.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302262101.57367.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 February 2003 20:40, Adam McKenna wrote:

Hi Adam,

> I'm having a VM issue on one of my servers running 2.4.20.
well, the vanilla VM, hmm, sorry: sucks :) for large boxen.

> As you can see there is plenty of memory sitting in buffers/cache.  The
> problem is that when our daily cronjobs run, the box starts swapping and
> the load goes up to 30.  The cronjobs are just the normal system cronjobs
> like updatedb, checksecurity, etc.
> I had this problem a while ago with 2.4.6-xfs and 2.4.14-xfs, but this is
> stock 2.4.20 and I was under the impression that the VM was relatively OK
> by now.
>
> adam@foxy:~$ grep -i mem /boot/config-2.4.20
> # CONFIG_NOHIGHMEM is not set
> # CONFIG_HIGHMEM4G is not set
> CONFIG_HIGHMEM64G=y
> CONFIG_HIGHMEM=y
> # Memory Technology Devices (MTD)
> # CONFIG_BLK_DEV_UMEM is not set
> # CONFIG_DEBUG_HIGHMEM is not set
> Any suggestions?
yes, use either -rmap (1) or -aa (2).

1.) www.surriel.com/patches (Rik van Riel)
2.) www.kernel.org/pub/linux/kernel/people/andrea/kernels (Andrea Arcangeli)

There is also a recent thread you may want to read:
- http://marc.theaimsgroup.com/?l=linux-kernel&m=104617534110371&w=2


ciao, Marc
