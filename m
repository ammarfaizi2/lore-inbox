Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281173AbRKEPTW>; Mon, 5 Nov 2001 10:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKEPTN>; Mon, 5 Nov 2001 10:19:13 -0500
Received: from fungus.teststation.com ([212.32.186.211]:28947 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S281173AbRKEPTA>; Mon, 5 Nov 2001 10:19:00 -0500
Date: Mon, 5 Nov 2001 16:18:30 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Smbfs + preempt on 2.4.10
In-Reply-To: <01110517015501.00794@nemo>
Message-ID: <Pine.LNX.4.30.0111051606590.17419-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, vda wrote:

> I have no idea of where I can start planting preempt_disable() and
> preempt_enable() in the 2.4.13 to narrow bug location.
> Any suggestions? Samba gurus may be more knowledgeable...
> --
> vda
> 
> PS. Urban, I dunno samba mailing list addr, feel free to crosspost this msg
> there and/or tell me appropriate email addr.

samba@samba.org, but if the kernel crashes smbd is probably not the guilty
party (it does run as root, or start as root, but I don't think it does
anything clever like write to /dev/kmem ... mmap possibly).

Nor do I think the samba developers are interested in crashing linux
kernels with experimental patches (more or less experimental anyway :)


> # Guess what is this?
>   client code page = 866
>   code page directory = /usr/lib/samba/lib/codepages

Normally that requires a 'character set' setting to get it right on the
linux side as well. But perhaps it guesses the right one ...

/Urban

