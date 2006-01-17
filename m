Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWAQTDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWAQTDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWAQTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:03:38 -0500
Received: from lucidpixels.com ([66.45.37.187]:33733 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932402AbWAQTDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:03:37 -0500
Date: Tue, 17 Jan 2006 14:03:36 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tomasz =?iso-8859-2?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Phil Oester <kernel@linuxace.com>, linux-kernel@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Kernel 2.6.15.1 + NFS is 4 times slower than FTP!?
In-Reply-To: <1137524502.7855.107.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0601171402230.25508@p34>
References: <Pine.LNX.4.64.0601161957300.16829@p34>  <20060117012319.GA22161@linuxace.com>
  <Pine.LNX.4.64.0601162031220.2501@p34>  <Pine.BSO.4.63.0601171846570.15077@rudy.mif.pg.gda.pl>
  <1137521483.14135.59.camel@localhost.localdomain>  <Pine.LNX.4.64.0601171324010.25508@p34>
  <1137523035.7855.91.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171338040.25508@p34>
  <1137523991.7855.103.camel@lade.trondhjem.org>  <Pine.LNX.4.64.0601171354510.25508@p34>
 <1137524502.7855.107.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file is 700MB.

Machine A (src) has 2GB of RAM / 2GB of swap
Machine B (dst) has 1GB of RAM / 2GB of swap.

Justin.

On Tue, 17 Jan 2006, Trond Myklebust wrote:

> On Tue, 2006-01-17 at 13:55 -0500, Justin Piszcz wrote:
>> Did you get my other e-mail?
>>
>> $ cp file /nfs/destination
>> $ lftp> put file
>
>
> Yes, but how big a file is this? Is it significantly larger than the
> amount of cache memory on the server? As I said, if ftp is failing to
> sync the file to disk, then you may be comparing apples and oranges.
>
> Cheers,
>  Trond
>
>> On Tue, 17 Jan 2006, Trond Myklebust wrote:
>>
>>> On Tue, 2006-01-17 at 13:38 -0500, Justin Piszcz wrote:
>>>> Writing from SRC(A) -> DST(B).
>>>> I have not tested reading, but as I recall there were similar speed issues
>>>> going the other way too, although I have not tested it recently.
>>>
>>> How were you testing it? I'm not sure that ftp will actually sync your
>>> file to disk (whereas that is pretty much mandatory for an NFS server),
>>> so unless you are transferring very large files, you would expect to see
>>> a speed difference due to caching of writes by the server.
>>>
>>> Cheers,
>>>  Trond
>>>
>
