Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbSLIVF0>; Mon, 9 Dec 2002 16:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSLIVF0>; Mon, 9 Dec 2002 16:05:26 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:60890 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S266157AbSLIVFZ>;
	Mon, 9 Dec 2002 16:05:25 -0500
Message-ID: <3DF5075A.2090009@colorfullife.com>
Date: Mon, 09 Dec 2002 22:12:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: wli@holomorphy.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.50-BK + 24 CPUs
References: <20021208212808.GY9882@holomorphy.com>	<1039389778.13079.1.camel@rth.ninka.net>	<3DF4CCCE.7040407@colorfullife.com> <20021209.121557.17268348.davem@redhat.com>
In-Reply-To: <20021209.121557.17268348.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: Manfred Spraul <manfred@colorfullife.com>
>   Date: Mon, 09 Dec 2002 18:03:10 +0100
>
>   Unfortunately zero-copy doesn't help to avoid the schedules:
>   Zero copy just avoid the copy to kernel - you still need one schedule 
>   for each page to be transfered.
>
>The zerocopy patches copied up to 64k (or rather, 16 pages, something
>like that) at once, that's going to lead to 16 times less schedules.
>
>The 64k number was decided arbitrarily (it's what freebsd's pipe code
>uses) and it can be experimented with.
>  
>
Only if user space writes in 64 kB chunks - if user space writes 4 kB 
chunks, then zerocopy doesn't help much against schedule [depending on 
the implementation, it halves the number of schedules].
And page table tricks (COW) tricks are not acceptable.

--
    Manfred

