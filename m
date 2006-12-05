Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967885AbWLEAVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967885AbWLEAVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967886AbWLEAVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:21:12 -0500
Received: from terminus.zytor.com ([192.83.249.54]:48733 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967885AbWLEAVL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:21:11 -0500
Message-ID: <4574BB63.4020800@zytor.com>
Date: Mon, 04 Dec 2006 16:20:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Janne Karhunen <Janne.Karhunen@gmail.com>, MrUmunhum@popdial.com,
       linux-kernel@vger.kernel.org
Subject: Re: Mounting NFS root FS
References: <4571CE06.4040800@popdial.com>	 <200612041912.30527.Janne.Karhunen@gmail.com>	 <1165256490.711.233.camel@lade.trondhjem.org>	 <200612042205.57577.Janne.Karhunen@gmail.com> <1165267623.5698.33.camel@lade.trondhjem.org>
In-Reply-To: <1165267623.5698.33.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Mon, 2006-12-04 at 22:05 +0200, Janne Karhunen wrote:
>> On Monday 04 December 2006 20:21, Trond Myklebust wrote:
>>
>>>>> 2) NFS provides persistent storage.
>>>> To me this sounds like a chicken and an egg problem. It
>>>> both depends and provides this at the same time :/. But
>>>> hey, if it's supposed to work then OK.
>>> ??? Locking depends on persistent storage, but persistent storage never
>>> depended on locking.
>> Except for the fact that to be able to mount anything RW you
>> generally _want_ to have locks. And can't have locks without 
>> the mount. Not that it wouldn't work, it's just that I would
>> not do it [for obvious reasons].
> 
> You just need to be careful to set it up correctly in the initrd: either
> make sure that you mount the root partition as 'nolock' or else make
> sure that you mount /var/lib/nfs, and start rpc.statd before you start
> init and any other applications that might need locking.
> 

The nfsmount which is in the klibc distribution supports running an ad 
hoc portmap daemon, which allows locking to be done by forwarding 
information to the "real" portmap for when the real rpc.statd is run.

	-hpa
