Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWC3ObA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWC3ObA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 09:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWC3ObA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 09:31:00 -0500
Received: from lucidpixels.com ([66.45.37.187]:61338 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932230AbWC3ObA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 09:31:00 -0500
Date: Thu, 30 Mar 2006 09:30:56 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: NFS/Kernel Problem: getfh failed: Operation not permitted
In-Reply-To: <1143728720.8074.41.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0603300929340.18696@p34>
References: <Pine.LNX.4.64.0603300813270.18696@p34> <1143728720.8074.41.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2006, Trond Myklebust wrote:

> On Thu, 2006-03-30 at 08:19 -0500, Justin Piszcz wrote:
>> The error is: rpc.mountd: getfh failed: Operation not permitted
>>
>> In order to fix this error, someone needs to run these commands on each
>> nfs server.
>>
>>     40  service nfs stop
>>     41  rm -f /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state
>> /var/lib/xtab
>>     42  touch /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state
>> /var/lib/xtab
>>     43  chmod 644 /var/lib/nfs/etab /var/lib/nfs/rmtab /var/lib/nfs/state
>> /var/lib/xtab
>>     44  service nfs start
>>
>> http://www.ccs.neu.edu/home/johan/personal/linux.html
>>
>> This issue seems to be more of an NFS issue than a kernel one, but I was
>> wondering what other people had to say about it.  There are a lot of
>> responses and questions concerning this error on google, but VERY few
>> people have a response or method of fixing it, much less finding a
>> permanent fix.
>>
>> Has anyone found a fix or work-around that does not require restarting
>> NFS?
>
> Very few people ought to be running RH-9 out there given that the
> official support expired several years ago.
Not running RH9, but running RHEL WS3, Taroon Update 4, however, the 
nfs-utils is 1.0.6-33EL, I know there were many fixes in 1.0.7+, could 
nfs-utils be the problem?  The kernel version in question is 
2.4.21-31.ELa1smp.

>
> Are you still seeing this problem with 2.6 kernels with /proc/fs/nfsd
> properly mounted?
Not using 2.6.

>
> Cheers,
>  Trond
>
