Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265068AbSKFNnU>; Wed, 6 Nov 2002 08:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSKFNnU>; Wed, 6 Nov 2002 08:43:20 -0500
Received: from line106-150.adsl.actcom.co.il ([192.117.106.150]:52688 "HELO
	mail.bard.org.il") by vger.kernel.org with SMTP id <S265068AbSKFNnT>;
	Wed, 6 Nov 2002 08:43:19 -0500
Date: Wed, 6 Nov 2002 15:49:35 +0200
From: "Marc A. Volovic" <marc@bard.org.il>
To: Pannaga Bhushan <bhushan@multitech.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A hole in kernel space!
Message-ID: <20021106134935.GA24234@glamis.bard.org.il>
References: <3DC903BE.F4CD5A52@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC903BE.F4CD5A52@multitech.co.in>
User-Agent: Mutt/1.4i
X-Operating-System: Linux glamis 2.4.20-pre10-ac2
X-message-flag: 'Oi! Muy Importante! Get yourself a real email client. http://www.mutt.org/'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Pannaga Bhushan:

> Hi all,
>         I am looking for a setup where I need to have a certain amount
> of data always available to the kernel. The size of data I am looking at
> is abt
> 40MB(preferably, but I will settle for 20MB too) . So the normal kmalloc

I wrote a driver which steals a certain amount of memory from the kernel
and makes it available to userspace (somewhat like the rd driver).
If you want - I can send it to you.

It exports a small device hierarchy which can be read, written and
mmap'ed. The memory is contiguous. Not VERY elegant, but works quite
well.

The driver steals a certain amount of memory from the kernel at boot
time, a-la the mem= parameter. I have used "holes" of up to 1GB in size.


Marc

-- 
---MAV
                        Linguists do it cunningly
Marc A. Volovic                                             marc@bard.org.il
