Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131469AbRBJPNC>; Sat, 10 Feb 2001 10:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131475AbRBJPMw>; Sat, 10 Feb 2001 10:12:52 -0500
Received: from colorfullife.com ([216.156.138.34]:15365 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S131469AbRBJPMk>;
	Sat, 10 Feb 2001 10:12:40 -0500
Message-ID: <3A855A85.A33BBF7F@colorfullife.com>
Date: Sat, 10 Feb 2001 16:13:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tom Leete <tleete@mountain.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon-SMP compiles & runs. inline fns honored.
In-Reply-To: <3A8554FA.AB33BE05@mountain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Leete wrote:
> 
> +
> +#ifndef _LINUX_MM_H
> +struct vm_area_struct;
> +#endif
> +
Are the #ifndef's necessary?
Could you try to remove the #ifndef and always declare the struct? gcc
shouldn't complain.

> +
> +/* Try removing /linux/fs.h in capability.h first
> +#ifndef _LINUX_CAPABILITY_H
> +typedef struct bogus_cap_struct {
> +       __u32 cap;
> +} kernel_cap_t;
> +#endif
> +*/
> +
Is is possible to get rid of that one?
What if somone modifies capability.h?

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
