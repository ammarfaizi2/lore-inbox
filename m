Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292332AbSBUKxU>; Thu, 21 Feb 2002 05:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292331AbSBUKxP>; Thu, 21 Feb 2002 05:53:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40974 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292329AbSBUKxE>;
	Thu, 21 Feb 2002 05:53:04 -0500
Message-ID: <3C74D18D.FCCFEA83@mandrakesoft.com>
Date: Thu, 21 Feb 2002 05:53:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5 IDE cleanup 11
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com> <3C737F29.7070105@evision-ventures.com> <3C74C03C.4060403@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2929,7 +2928,6 @@
>         capacity:               ide_cdrom_capacity,
>         special:                NULL,
>         proc:                   NULL,
> -       driver_init:            ide_cdrom_init,
>         driver_reinit:          ide_cdrom_reinit,
>  };
>  
> @@ -2967,7 +2965,7 @@
>         DRIVER(drive)->busy--;
>         failed--;
>  
> -       ide_register_module(&ide_cdrom_driver);
> +       revalidate_drives();
>         MOD_DEC_USE_COUNT;
>         return 0;
>  }

hum, I'm not sure that removing ->driver_init is a good idea.

Seems like a loss of flexibility to me, not a cleanup, and I wonder if
you have thought through all the paths that wind up calling
->driver_init.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
