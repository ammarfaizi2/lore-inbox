Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313567AbSDHGaH>; Mon, 8 Apr 2002 02:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313568AbSDHGaG>; Mon, 8 Apr 2002 02:30:06 -0400
Received: from ns1.crl.go.jp ([133.243.3.1]:19082 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S313567AbSDHGaF>;
	Mon, 8 Apr 2002 02:30:05 -0400
Date: Mon, 8 Apr 2002 15:29:47 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: Keith Owens <kaos@ocs.com.au>
cc: marcelo@conectiva.com.br,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Extraversion in System.map? 
In-Reply-To: <422.1018246695@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0204081526200.548-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Keith Owens wrote:

> System.map only contains the numeric kernel version.  After all, it is
> difficult to convert 2.4.19-pre6 to Version_132115-pre6 when symbols
> cannot contain '-'.

Well, that has an obvious solution, but modifying the Version string
would likely break something.  Adding another string would work.  It
could even be done without making the kernel image bigger.  In fact,
the Version_* symbol (and Extraversion_* symbol) could both be made
__initdata, couldn't they?

> Don't reinvent the wheel, use ksymoops -s save.map.  ksymoops has all
> the verification code that I can think off, -s writes the merged map
> including module information.

Now there's a clever idea.

