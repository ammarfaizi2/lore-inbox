Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318946AbSHWQxW>; Fri, 23 Aug 2002 12:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSHWQxW>; Fri, 23 Aug 2002 12:53:22 -0400
Received: from smtp03.web.de ([217.72.192.158]:7951 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S318946AbSHWQxW>;
	Fri, 23 Aug 2002 12:53:22 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac1
References: <200208231046.g7NAk2914276@devserv.devel.redhat.com>
	<20020823163056.GA7426@sci.fi>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Fri, 23 Aug 2002 18:56:04 +0200
In-Reply-To: <20020823163056.GA7426@sci.fi> (Anssi Saari's message of "Fri,
 23 Aug 2002 19:30:56 +0300")
Message-ID: <8765y1a50b.fsf@plailis.homelinux.net>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anssi!

* Anssi Saari writes:
>On Fri, Aug 23, 2002 at 06:46:02AM -0400, Alan Cox wrote:
>>IDE status
>[...]

>This new IDE stuff has certainly worsened my longstanding CD writing problem.
>Data writes go fine at 16x. Audio writes work fine at 16x in FreeBSD
>and Windows 98 with the same system. DMA is on, unmask_irq is on, 32bit
>transfers are on, but don't matter much.

If you burn data in DAO mode you will have the same behaviour. Have you
tried to toggle CONFIG_IDEPCI_SHARE_IRQ? It helped me a lot. Also I
have to disable umaskirq, otherwise I have the same problems.
Unfortunately I can't use the latest ac series because of a mysterious
problem with ide-scsi.
One thing I still do not understand is:
IS DMA (theoretically) possible for stuff like c2scans, DAO writing,
audio grabbing? From what I read in the LKML archives and from what
Andre wrote me, I'd say no, but on the other hand I can do a c2scan at
5MB/s with almost no processor usage. Can't really be PIO.

regards
Markus

