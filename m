Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSDJLiP>; Wed, 10 Apr 2002 07:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312610AbSDJLiO>; Wed, 10 Apr 2002 07:38:14 -0400
Received: from smtp02.web.de ([217.72.192.151]:47902 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S312601AbSDJLiO>;
	Wed, 10 Apr 2002 07:38:14 -0400
Message-ID: <3CB42401.2080007@web.de>
Date: Wed, 10 Apr 2002 13:37:37 +0200
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Udo A. Steinberg" <reality@delusion.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8-pre3 linking error
In-Reply-To: <3CB418B7.BB5CFEB9@delusion.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Udo A. Steinberg wrote:

>Hi,
>
>2.5.8-pre3 fails to link here:
>
>init/main.o: In function `start_kernel':
>init/main.o(.text.init+0x681): undefined reference to `setup_per_cpu_areas'
>
>-Udo.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
As you could see a few lines above setup_per_cpu_areas gets defined only 
of CONFIG_SMP is set. So find the line in the function start_kernel in 
init/main.c ( about line #320 IIRC ) where setup_per_cpu_areas gets 
called and put #ifdef CONFIG_SMP and #endif around it.

Cheers,
Todor

