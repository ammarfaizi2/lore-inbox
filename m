Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSFQQxY>; Mon, 17 Jun 2002 12:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316047AbSFQQxX>; Mon, 17 Jun 2002 12:53:23 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:38087 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S315943AbSFQQxV>; Mon, 17 Jun 2002 12:53:21 -0400
Message-ID: <3D0E10BA.3010604@drugphish.ch>
Date: Mon, 17 Jun 2002 18:39:22 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS (vfs-related) syscall logging
References: <3D0A5E64.3020705@drugphish.ch> <shsadpv7y3y.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>      > I will extend it and add yet another proc-fs variable in
>      > /proc/sys/sunrpc/ which will represent a bitmask to selectively
>      > enable/disable which syscalls should be logged.
> 
> 
> Ugh...
> 
> The volume of information you propose to log is going to be seriously
> huge and *will* affect performance. It would probably be a lot more

I'm fully aware of that. But we have the problem that we need C2'ish 
audit trails and logging facilities. It's a requirement in the company I 
work for. Linux unfortunately isn't quite there yet but with the LSM 
framework it would be possible. I know that SGI at a certain point had 
put a lot of effort into getting something like that into the LSM 
framework. I simply can't wait (for that specific NFS requirement) until 
it is part of the official kernel tree so I hacked that patch together. 
It's easier to forward port my simple patch than to have LSM and a patch.

[Besides all that my boss thinks we can handle the amount of overhead 
and the logged data and he pays my check, so I do it. :)]

> efficient to log using 'tcpdump' (and the libpcap binary format)
> instead of all those printks.

Can't do that, company policy and I doubt this would be more efficient 
since you need a damn intelligent parser to get the same information 
from a packet dump.

But thanks for your input. Maybe you or someone else would be able to 
give me a response to my other questions too, if possible. I'd really 
appreciate it.

Best regards and thanks for your effort,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

