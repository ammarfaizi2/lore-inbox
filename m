Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSF1E3Q>; Fri, 28 Jun 2002 00:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317056AbSF1E3Q>; Fri, 28 Jun 2002 00:29:16 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:14274 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S317054AbSF1E3P>; Fri, 28 Jun 2002 00:29:15 -0400
Message-ID: <3D1BE698.44B04F6B@cisco.com>
Date: Fri, 28 Jun 2002 10:01:20 +0530
From: Manik Raina <manik@cisco.com>
Organization: Cisco Systems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Re: enums
References: <3D1B0B95.51E13621@cisco.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	If no one has any objections, Can this be applied as a patch ?


Manik Raina wrote:
> 
> is there a particular reason we dislike constructs as attached in the
> diffs below ?
> with enums, we dont have to increment MAX_NR_ZONES everytime a new one
> is added .
> 
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> diff -u -r -U 6 cmp/include/linux/mmzone.h linux-2.5.24/include/linux/mmzone.h
> --- cmp/include/linux/mmzone.h  Fri Jun 21 04:23:42 2002
> +++ linux-2.5.24/include/linux/mmzone.h Thu Jun 27 18:00:25 2002
> @@ -88,16 +88,21 @@
>          * rarely used fields:
>          */
>         char                    *name;
>         unsigned long           size;
>  } zone_t;
> 
> -#define ZONE_DMA               0
> -#define ZONE_NORMAL            1
> -#define ZONE_HIGHMEM           2
> -#define MAX_NR_ZONES           3
> +enum zone_type {
> +
> +     ZONE_DMA,
> +     ZONE_NORMAL,
> +     ZONE_HIGHMEM,
> +     MAX_NR_ZONES,
> +
> +};
> +
> 
>  /*
>   * One allocation request operates on a zonelist. A zonelist
>   * is a list of zones, the first one is the 'goal' of the
>   * allocation, the other zones are fallback zones, in decreasing
>   * priority.
