Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319315AbSIFS3f>; Fri, 6 Sep 2002 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319318AbSIFS3f>; Fri, 6 Sep 2002 14:29:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31663 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319315AbSIFS3d>; Fri, 6 Sep 2002 14:29:33 -0400
Message-ID: <3D78F4E6.3020101@us.ibm.com>
Date: Fri, 06 Sep 2002 11:33:10 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020822
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       "David S. Miller" <davem@redhat.com>, hadi@cyberus.ca,
       tcw@tempest.prismnet.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <3D78C9BD.5080905@us.ibm.com> <53430559.1031304588@[10.10.2.3]> <3D78E7A5.7050306@us.ibm.com> <20020906202646.A2185@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>c0106e59 42693    1.89176     restore_all
>>c01dfe68 42787    1.89592     sys_socketcall
>>c01df39c 54185    2.40097     sys_bind
>>c01de698 62740    2.78005     sockfd_lookup
>>c01372c8 97886    4.3374      fput
>>c022c110 125306   5.55239     __generic_copy_to_user
>>c01373b0 181922   8.06109     fget
>>c020958c 199054   8.82022     tcp_v4_get_port
>>c0106e10 199934   8.85921     system_call
>>c022c158 214014   9.48311     __generic_copy_from_user
>>c0216ecc 257768   11.4219     inet_bind
> 
> The profile looks bogus. The NIC driver is nowhere in sight. Normally
> its mmap IO for interrupts and device registers should show. I would
> double check it (e.g. with normal profile) 

Actually, oprofile separated out the acenic module from the rest of the 
kernel.  I should have included that breakout as well. but it was only 1.3 
of CPU:
1.3801 0.0000 /lib/modules/2.4.18+O1/kernel/drivers/net/acenic.o


-- 
Dave Hansen
haveblue@us.ibm.com

