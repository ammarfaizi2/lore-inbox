Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSDOM0k>; Mon, 15 Apr 2002 08:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312612AbSDOM0j>; Mon, 15 Apr 2002 08:26:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:7181 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S312601AbSDOM0i>;
	Mon, 15 Apr 2002 08:26:38 -0400
Message-ID: <3CBAB86F.6000608@evision-ventures.com>
Date: Mon, 15 Apr 2002 13:24:31 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: admin@nextframe.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup:
 idebus=66 -- BAD OPTION"
In-Reply-To: <20020415112332.A181@sexything> <3CBA8E70.5010605@evision-ventures.com> <20020415141658.A140@sexything>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Morten Helgesen wrote:
> Hey again, Martin :)
> 
> What do you think about the following :

What I think? I think it's abviously right... Thank you very much
and sorry for the inconvenience!

And judging from the other typos fixed in patch number 34 I think
that I should stick to my "principles" and don't write code past 02:00 o'clock
... :-).

> 
> --- clean-linux-2.5.8/drivers/ide/ide.c Sun Apr 14 21:18:52 2002
> +++ patched-linux-2.5.8/drivers/ide/ide.c       Mon Apr 15 14:09:18 2002
> @@ -3120,7 +3120,7 @@
>         /*
>          * Look for bus speed option:  "idebus="
>          */
> -       if (strncmp(s, "idebus", 6)) {
> +       if (strncmp(s, "idebus", 6) == 0) {
>                 if (match_parm(&s[6], NULL, vals, 1) != 1)
>                         goto bad_option;
>                 if (vals[0] >= 20 && vals[0] <= 66) {
> 
> gives :
> 
> Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
> ide_setup: idebus=66
> ide: system bus speed 66MHz
> 
> works like a charm :)

