Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135321AbRDWP0E>; Mon, 23 Apr 2001 11:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135346AbRDWPZv>; Mon, 23 Apr 2001 11:25:51 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53175 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135293AbRDWPYS>;
	Mon, 23 Apr 2001 11:24:18 -0400
Message-ID: <3AE44925.307069E4@mandrakesoft.com>
Date: Mon, 23 Apr 2001 11:24:21 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pedantic code cleanup - am I wasting my time with this?
In-Reply-To: <3AE449A3.3050601@eisenstein.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> 
> Hi people,
> 
> I'm reading through various pieces of source code to try and get an
> understanding of how the kernel works (with the hope that I'll
> eventually be able to contribute something really usefull, but you've
> got to start somewhere ;)
> 
> While reading through the source I've stumbled across various bits and
> pieces that are not exactely wrong, but not strictly correct either. I
> was wondering if I would be wasting my time by cleaning this up or if it
> would actually be appreciated. One example of these things is the patch
> below:
> 
> --- linux-2.4.3-vanilla/include/linux/rtnetlink.h       Sun Apr 22
> 02:29:20 2001
> +++ linux-2.4.3/include/linux/rtnetlink.h       Mon Apr 23 17:09:02 2001
> @@ -112,7 +112,7 @@
>          RTN_PROHIBIT,           /* Administratively prohibited  */
>          RTN_THROW,              /* Not in this table            */
>          RTN_NAT,                /* Translate this address       */
> -       RTN_XRESOLVE,           /* Use external resolver        */
> +       RTN_XRESOLVE            /* Use external resolver        */
>   };
> 
>   #define RTN_MAX RTN_XRESOLVE
> @@ -278,7 +278,7 @@
>   #define RTAX_CWND RTAX_CWND
>          RTAX_ADVMSS,
>   #define RTAX_ADVMSS RTAX_ADVMSS
> -       RTAX_REORDERING,
> +       RTAX_REORDERING
>   #define RTAX_REORDERING RTAX_REORDERING
>   };
> 
> @@ -501,7 +501,7 @@
>          TCA_OPTIONS,
>          TCA_STATS,
>          TCA_XSTATS,
> -       TCA_RATE,
> +       TCA_RATE

These patches increase the possibility of errors when adding future
items to these lists.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
