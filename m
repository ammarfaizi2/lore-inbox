Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSHOBPd>; Wed, 14 Aug 2002 21:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316430AbSHOBPd>; Wed, 14 Aug 2002 21:15:33 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51194 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316397AbSHOBPc>; Wed, 14 Aug 2002 21:15:32 -0400
Subject: Re: Performance differences for recent kernels running forky test.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1029352630.14756.140.camel@spc9.esa.lanl.gov>
References: <1029352630.14756.140.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Aug 2002 02:17:41 +0100
Message-Id: <1029374261.28236.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 20:17, Steven Cole wrote:
> I ran the following lots_of_forks.sh script for several kernels.
> 
> http://people.nl.linux.org/~phillips/patches/lots_of_forks.sh
> 
> using time -v sh lots_of_forks.sh
> 
> The results for 2.4.20-pre2 and 2.4.20-pre2-ac1 are very different.

I'd expect that to be the case. Rmap is a huge win for many things but
its not a good win on fork times. The question is whether fork bombs
dominate your working load and what the tradeoffs are between saner VM
behaviour and less accounting overhead.

Its not clear what the answer is.

