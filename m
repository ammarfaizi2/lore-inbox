Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264212AbUD0WYS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264212AbUD0WYS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 18:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264374AbUD0WYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 18:24:18 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:26308 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id S264212AbUD0WYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 18:24:15 -0400
Organization: 
Date: Wed, 28 Apr 2004 01:24:05 +0300 (EEST)
From: Panagiotis Papadakos <papadako@csd.uoc.gr>
To: Kenneth Johansson <ken@kenjo.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] DVD writing in 2.6.6-rc2
In-Reply-To: <1083088772.2679.11.camel@tiger>
Message-ID: <Pine.GSO.4.58.0404280122510.5798@thanatos.csd.uoc.gr>
References: <1083088772.2679.11.camel@tiger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a growisofs 5.19 problem.
You should download:
http://fy.chalmers.se/~appro/linux/DVD+RW/tools/dvd+rw-tools-5.19-1.4.9.7.tar.gz

	Panagiotis Papadakos

On Tue, 27 Apr 2004, Kenneth Johansson wrote:

> I have a problem when using growisofs version 5.19.
>
> The problem is that in the very end when gowisofs tries to flush the
> cache. When stracing the process I can see it sits in a call to poll
> that never returns.
>
> I noticed that if I start growisofs and later attach to it with "strace
> -p" I can make it continue with killing the strace process. just to see
> it hang in the next poll. But re attaching then killing the strace again
> a few times and growisofs finally dose a normal exit.
>
> This happens every time.
>
> The only unusual thing with my setup is that I only have the DVD burner
> on the IDE controller no disks so I guess it's some type of missed
> interrupt.
>
> I looked at the drivers/ide/pci/via82cxxx.c but that one did not do much
> apart from setting a few configurations so I guess it's some generic
> code that dose the real work.
>
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.38
> South Bridge:                       VIA vt8233a
> Revision:                           ISA 0x0 IDE 0x6
> Highest DMA rate:                   UDMA133
> BM-DMA base:                        0x9800
> PCI clock:                          33.3MHz
> Master Read  Cycle IRDY:            0ws
> Master Write Cycle IRDY:            0ws
> BM IDE Status Register Read Retry:  yes
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:          yes                 yes
> End Sector FIFO flush:         no                  no
> Prefetch Buffer:               no                  no
> Post Write Buffer:             no                  no
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   80w                 80w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:        PIO       PIO      UDMA      UDMA
> Address Setup:      120ns     120ns     120ns     120ns
> Cmd Active:         360ns     360ns      90ns      90ns
> Cmd Recovery:       210ns     210ns      30ns      30ns
> Data Active:        330ns     330ns      90ns      90ns
> Data Recovery:      270ns     270ns      30ns      30ns
> Cycle Time:         600ns     600ns      60ns      60ns
> Transfer Rate:    3.3MB/s   3.3MB/s  33.3MB/s  33.3MB/s
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
