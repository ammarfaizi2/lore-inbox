Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280171AbRJaLoK>; Wed, 31 Oct 2001 06:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280174AbRJaLoA>; Wed, 31 Oct 2001 06:44:00 -0500
Received: from aloha.egartech.com ([62.118.81.133]:58373 "HELO
	mx02.egartech.com") by vger.kernel.org with SMTP id <S280171AbRJaLnu>;
	Wed, 31 Oct 2001 06:43:50 -0500
Message-ID: <3BDFE4A3.309D66CE@egartech.com>
Date: Wed, 31 Oct 2001 14:46:43 +0300
From: Kirill Ratkin <kratkin@egartech.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Rozhavsky <mrozhavsky@opticalaccess.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Call kernel function from module
In-Reply-To: <01103112311302.00794@nemo> <3BDFD866.E6E997CC@egartech.com> <20011031133438.O24143@opticalaccess.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 31 Oct 2001 11:44:19.0534 (UTC) FILETIME=[606D26E0:01C16201]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Rozhavsky wrote:
> 
> [snip]
> >
> > Hi! Could somebody help me? I added several functions (not sys calls) to
> > kernel as hardcoded part. Then I write modules which will be call these
> > functions. But when I load module insmod says me 'can't resolve symbol
> > my_func_name'.
> > I exported all my functions in netsyms.c file. Do you know how I can see
> > my function?
> 
> use EXPORT_SYMBOL macro from include/module.h
Yes. I added it in netsyms.c and I see all my functions in System.map
file. (into ksyms too)

#ifdef CONFIG_BATON
#include <linux/baton.h>
EXPORT_SYMBOL(baton_init);
EXPORT_SYMBOL(baton_register_hook);
EXPORT_SYMBOL(baton_unregister_hook);
#endif

> 
> >
> > Regards,
> > Niktar.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> Best regards.
> 
> --
>    Michael Rozhavsky                    Tel:    +972-4-9936248
>    mrozhavsky@opticalaccess.com         Fax:    +972-4-9890564
>    Optical Access
>    Senior Software Engineer             www.opticalaccess.com
