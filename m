Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273419AbRINQKr>; Fri, 14 Sep 2001 12:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273422AbRINQKh>; Fri, 14 Sep 2001 12:10:37 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:24580 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S273419AbRINQKU>;
	Fri, 14 Sep 2001 12:10:20 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: andrew may <acmay@acmay.homeip.net>
Date: Fri, 14 Sep 2001 18:09:58 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: missing break? linux/drivers/video/riva/fbdev.c
CC: Ani Joshi <ajoshi@shell.unixbox.com>, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <372A2445C86@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 01 at 21:26, andrew may wrote:
> diff -u --recursive --new-file v2.4.9/linux/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
> --- v2.4.9/linux/drivers/video/riva/fbdev.c Wed Jul 25 17:10:24 2001
> +++ linux/drivers/video/riva/fbdev.c    Fri Sep  7 09:28:38 2001
> @@ -1109,6 +1109,8 @@
>         break;
>  #endif
>  #ifdef FBCON_HAS_CFB16
> +   case 15:
> +       rc = 15;    /* fix for 15 bpp depths on Riva 128 based cards */
>     case 16:
>         rc = 16;    /* directcolor... 16 entries SW palette */
>         break;      /* Mystique: truecolor, 16 entries SW palette, HW palette hardwired into 1:1 mapping */
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
I do not think that this comment should be in rivafb driver ;-) It
is completely unrelated to Riva hardware, it came from matroxfb.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                                             
