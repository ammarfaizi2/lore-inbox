Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261255AbRELOeH>; Sat, 12 May 2001 10:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261257AbRELOd5>; Sat, 12 May 2001 10:33:57 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45212 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261255AbRELOdu>;
	Sat, 12 May 2001 10:33:50 -0400
Message-ID: <3AFD49CC.655E3E4F@mandrakesoft.com>
Date: Sat, 12 May 2001 10:33:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] winbond-840 update
In-Reply-To: <3AFD0A27.49C11072@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> @@ -437,9 +439,9 @@
>         if (option > 0) {
>                 if (option & 0x200)
>                         np->full_duplex = 1;
> -               np->default_port = option & 15;
> -               if (np->default_port)
> -                       np->medialock = 1;
> +               if (option & 15)
> +                       printk(KERN_INFO "%s: ignoring user supplied media type %d",
> +                               dev->name, option & 15);
>         }
>         if (find_cnt < MAX_UNITS  &&  full_duplex[find_cnt] > 0)
>                 np->full_duplex = 1;

I'm not sure this part is something we want in the mainstream kernel...

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
