Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132686AbRDIEkU>; Mon, 9 Apr 2001 00:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbRDIEkK>; Mon, 9 Apr 2001 00:40:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:10217 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132686AbRDIEj7>;
	Mon, 9 Apr 2001 00:39:59 -0400
Date: Mon, 9 Apr 2001 00:39:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: warren <warren@infortrend.com.tw>
cc: linux-kernel@vger.kernel.org
Subject: Re: race condition on looking up inodes
In-Reply-To: <000201c0c0a4$eb5c7b10$321ea8c0@saturn>
Message-ID: <Pine.GSO.4.21.0104090033280.7440-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Apr 2001, warren wrote:

> 
> 
> Hi,
>     I had post a simillar message before.
>     Thanks for the replay from Albert D. Cahalan. But i found some results
> confusing me.
>     For example,  process 1 and process 2 run concurrently and execute the
> following system calls.
> 
>     rename("/usr/hybrid/cfg/data","/usr/mytemp/data1"); /*for process 1*/
> 
>    ----------------------------------------------------------------
> 
>   rename("/usr/mytemp/data1","/usr/test");/* for process 2*/

>   ----------------------------------------------------------------
>   It is possible that context switch happens when process 1 is look ing up
> the inode for "/usr/mytemp/data1"  or the inode for "/usr/hybrid/cfg/data".

>  It will result in diffrent behaviour for process 2 and confuses the
> application.

>   If so,how does Linux solve?

Solves what, precisely? Result depends on the order of these calls. If
you don't provide any serialization - you get timing-dependent results
you were asking for. What's the problem and what behaviour do you expect?

Besides, what's the difference caused by the moment of context switch?

