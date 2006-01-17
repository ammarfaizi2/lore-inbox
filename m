Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWAQSin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWAQSin (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWAQSin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:38:43 -0500
Received: from lucidpixels.com ([66.45.37.187]:33180 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932343AbWAQSim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:38:42 -0500
Date: Tue, 17 Jan 2006 13:38:41 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <1137523035.7855.91.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0601171338040.25508@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
  <1137521483.14135.59.camel@localhost.localdomain>  <Pine.LNX.4.64.0601171324010.25508@p34>
 <1137523035.7855.91.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Writing from SRC(A) -> DST(B).
I have not tested reading, but as I recall there were similar speed issues 
going the other way too, although I have not tested it recently.

Justin.

On Tue, 17 Jan 2006, Trond Myklebust wrote:

> On Tue, 2006-01-17 at 13:24 -0500, Justin Piszcz wrote:
>> Alan, is it normal for FTP to be 2x as fast as NFS?
>> With 100mbps, I never seemed to have any issues, but with GIGABIT I
>> definitely see all sorts of weird issues.
>
> Reading or writing?
>
> The readahead algorithm has been borken in 2.6.x for at least the past 6
> months. It leads to NFS collapsing down to 4k reads on the wire instead
> of doing 32k or 64k.
> An effort was made to look at fixing this, but it turns out that nobody
> really understands the current messy implementation, and so progress has
> been slow.
>
> Cheers,
>  Trond
>
