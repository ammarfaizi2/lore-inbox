Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310335AbSCGOUY>; Thu, 7 Mar 2002 09:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310346AbSCGOUN>; Thu, 7 Mar 2002 09:20:13 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:55285 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310335AbSCGOUB>; Thu, 7 Mar 2002 09:20:01 -0500
Message-ID: <3C877710.CAE1AFD3@redhat.com>
Date: Thu, 07 Mar 2002 14:20:00 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_YIELD undeclared with Trond's NFS patch w/2.4.19-pre2-ac2
In-Reply-To: <20020307084514.C16224@lapsony.mydomain.here> <Pine.LNX.3.95.1020307085809.19727A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> You need to change loops that do something like:
> 
>     while(something)
>     {
>         current->policy |= SCHED_YIELD;
>         schedule();
>     }
> 
>     to:
> 
>     while(something)
>         sys_sched_yield();
> 

such loops are a great way to create livelock and other nasties in the
kernel
and should be avoided at all cost (esp if you use preemptable kernels)
