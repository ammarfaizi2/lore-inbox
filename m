Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312827AbSCZX1u>; Tue, 26 Mar 2002 18:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312838AbSCZX1l>; Tue, 26 Mar 2002 18:27:41 -0500
Received: from ns1.baby-dragons.com ([199.33.245.254]:25745 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S312827AbSCZX1a>; Tue, 26 Mar 2002 18:27:30 -0500
Date: Tue, 26 Mar 2002 18:27:12 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-atm-general@lists.sourceforge.net,
        Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ATM locking fix.
In-Reply-To: <20020326.145202.122762468.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0203261825410.12942-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Dave ,  I have attached the linux-atm list so they can see
	what you have found .  Hth ,  JimL

On Tue, 26 Mar 2002, David S. Miller wrote:

>
> I'm applying this patch with some minor cleanups of my own.
>
> I went and then checked around for atm_find_dev() users to
> make sure they held the atm_dev_lock, and I discovered several pieces
> of "hidden treasure".
>
> Firstly, have a look at net/atm/common.c:atm_ioctl() and how it
> accesses userspace while holding atm_dev_lock.  That is just the
> tip of the iceberg.
>
> ATM sorely needs a maintainer.  Any of the kernel janitors want to
> learn how ATM works? :-))))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+



