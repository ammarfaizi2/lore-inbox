Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDNSVO>; Sat, 14 Apr 2001 14:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDNSVF>; Sat, 14 Apr 2001 14:21:05 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:32280 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S132517AbRDNSUy>; Sat, 14 Apr 2001 14:20:54 -0400
Date: Sat, 14 Apr 2001 20:20:49 +0200
From: Marc SCHAEFER <schaefer@alphanet.ch>
Message-Id: <200104141820.UAA16097@vulcan.alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI tape corruption problem
In-Reply-To: <Pine.LNX.4.05.10104141940320.12788-100000@callisto.of.borg>
Organization: ALPHANET NF -- Not for profit telecom research
X-Newsreader: TIN [UNIX 1.3 unoff BETA 970705; i586 Linux 2.0.38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.05.10104141940320.12788-100000@callisto.of.borg> you wrote:
> So you make gzip use blocks of 32 kB.

no, infact it really makes it using blocks of 4k (a PIPE_SIZE is 4k), so
it is really equivalent to bs=4k. dd doesn't re-join blocks when
they are smaller then bs=, unless you specify obs=32k.

I have been playing with buffer recently and mixed up both.
buffer is really a nice tool.

But as I said, as long as you don't play with non-fixed block size
you don't have problems.

sorry for mixup.
