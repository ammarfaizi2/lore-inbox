Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292294AbSCKUG2>; Mon, 11 Mar 2002 15:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292554AbSCKUGS>; Mon, 11 Mar 2002 15:06:18 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:51909 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S292294AbSCKUF6>;
	Mon, 11 Mar 2002 15:05:58 -0500
Date: Mon, 11 Mar 2002 21:04:19 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Maksim Krasnyanskiy <maxk@qualcomm.com>
Cc: Robert Love <rml@tech9.net>, Frode Isaksen <fisaksen@bewan.com>,
        mitch@sfgoth.com, linux-kernel@vger.kernel.org,
        marcelo Tosatti <marcelo@conectiva.com.br>, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] ATM locking fix. [Re: [PATCH] spinlock not locked when unlocking in atm_dev_register]
Message-ID: <20020311210419.A27706@fafner.intra.cogenit.fr>
In-Reply-To: <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com> <5.1.0.14.2.20020307141124.084dbde8@mail1.qualcomm.com> <20020309194515.B6626@fafner.intra.cogenit.fr> <5.1.0.14.2.20020311103743.051b0700@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20020311103743.051b0700@mail1.qualcomm.com>; from maxk@qualcomm.com on Mon, Mar 11, 2002 at 10:38:47AM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim Krasnyanskiy <maxk@qualcomm.com> :
[...]
> >- atm_proc_dev_register issues kmalloc(...,GFP_KERNEL) and atm_dev_lock
> >   is hold
> No. It uses GFP_ATOMIC.

atm_proc_dev_register
    ^^^^
2.4.18 - net/atm/proc.c:554
        dev->proc_name = kmalloc(strlen(dev->type)+digits+2,GFP_KERNEL);

> grep 'net/atm/proc' patch-2.4.19-pre2 -> nada
> grep 'net/atm/proc' patch-2.4.19-pre2-ac3 -> nada

I am alone in my parallel universe ? :o)

-- 
Ueimor 
