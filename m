Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSECIpG>; Fri, 3 May 2002 04:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315608AbSECIpF>; Fri, 3 May 2002 04:45:05 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:45514 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315607AbSECIpE>; Fri, 3 May 2002 04:45:04 -0400
Date: Fri, 3 May 2002 10:24:07 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jaroslav Kysela <perex@suse.cz>
Cc: A Guy Called Tyketto <tyketto@wizard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.13 sound compile error
In-Reply-To: <Pine.LNX.4.33.0205030942550.513-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.44.0205031023190.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Jaroslav Kysela wrote:

> This patch fixes the problem:
> 
> --- misc.c	29 Apr 2002 15:57:08 -0000	1.13
> +++ misc.c	3 May 2002 07:42:33 -0000	1.14
> @@ -96,10 +96,10 @@
>  	if (format[0] == '<' && format[1] >= '0' && format[1] <= '9' && format[2] == '>') {
>  		char tmp[] = "<0>";
>  		tmp[1] = format[1];
> -		printk("%sALSA %s:%d: ", tmp, file, line);
> +		printk("%sALSA: ", tmp);
>  		format += 3;
>  	} else {
> -		printk(KERN_DEBUG "ALSA %s:%d: ", file, line);
> +		printk(KERN_DEBUG "ALSA: ");
>  	}

woaaahh!! 8)

-- 
http://function.linuxpower.ca
		

