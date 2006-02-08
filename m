Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWBHUHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWBHUHR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWBHUHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:07:17 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:61494 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030575AbWBHUHP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:07:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uWIoLIJfwQkEDHHKFxORG/+5Ko4GBvF5gFNjwSNq4ca0ge1s1uuuoXY7vldcaBWjHqwWXR7J4EGo7xRUogxBC+AFajlj2rgd7nN5RbYHjcDCSwwh9MKNKhgnTcIHeMCTR+JaE4Sio1nPi/77M/EMa3V+DtGkiJKBA4k7GG9Pw6U=
Message-ID: <4807377b0602081207s7604eceahb8bf4af6715a6534@mail.gmail.com>
Date: Wed, 8 Feb 2006 12:07:14 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Yoseph Basri <yoseph.basri@gmail.com>,
       "Boris B. Zhmurov" <bb@kernelpanic.ru>
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
Cc: linux-kernel@vger.kernel.org, NetDEV list <netdev@vger.kernel.org>
In-Reply-To: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e282236e0602070146p1ed3fdb6k74aa75e15bbc37a3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this should be on netdev (cc'd), i included some of the thread here.

On 2/7/06, Yoseph Basri <yoseph.basri@gmail.com> wrote:
> Hello kernel maillist,
>
> I'm new member maillist.
>
> Currently, I receive the warning log from my kernel.
>
> Since update to
> Linux  2.6.14.3 #1 SMP Fri Nov 25 20:20:05 SGT 2005 i686 GNU/Linux from 2.4,
>
> I am getting the warning log:
>
> kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> net/core/stream.c (279)
> kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> net/ipv4/af_inet.c (148)
>
> Any information about this issue, and how to solve this problem ?
>
> Another server that i rolled back from 2.6.14 to 2.4 kernel and has no
> warning again. is this bug from 2.6 kernel?
>
> Thanks for your info.

On 2/7/06, Yoseph Basri <yoseph.basri@gmail.com> wrote:
> Hi Boris,
>
> I think so, here is from the dmeg info:
>
> Intel(R) PRO/1000 Network Driver - version 6.0.60-k2
> Copyright (c) 1999-2005 Intel Corporation.
> ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 29 (level, low) -> IRQ 16
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> ACPI: PCI Interrupt 0000:06:08.1[B] -> GSI 30 (level, low) -> IRQ 17
> e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
> e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
> e100: Copyright(c) 1999-2005 Intel Corporation
>
> any info regarding this warning?
>
> YB
>
> On 2/7/06, Boris B. Zhmurov <bb@kernelpanic.ru> wrote:
> > Hello, Yoseph Basri.
> >
> > On 07.02.2006 12:46 you said the following:
> >
> > > I am getting the warning log:
> > >
> > > kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> > > net/core/stream.c (279)
> > > kernel: KERNEL: assertion (!sk->sk_forward_alloc) failed at
> > > net/ipv4/af_inet.c (148)
> >
> >
> > Do you have Intel Pro 1000 network card? Same here...

whats the relevance of e1000?

I though Herbert had fixed these, and it looks like half the patches
got into 2.6.14.3, but not the fix to the fix committed on 9-6 (not in
2.6.14.* at all)

Jesse
