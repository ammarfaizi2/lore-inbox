Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSHYKwJ>; Sun, 25 Aug 2002 06:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSHYKwJ>; Sun, 25 Aug 2002 06:52:09 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:47544 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317182AbSHYKwH>; Sun, 25 Aug 2002 06:52:07 -0400
Date: Sun, 25 Aug 2002 13:13:00 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Gerald Teschl <gerald@esi.ac.at>
Cc: linux-kernel@vger.kernel.org, <linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ad1848 infinite loop fix
In-Reply-To: <Pine.LNX.4.44.0208242324450.29094-100000@keen.esi.ac.at>
Message-ID: <Pine.LNX.4.44.0208251255230.28574-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2.4.19/drivers/sound/ad1848.c.orig    Sat Aug 24 23:19:54 2002
> +++ linux-2.4.19/drivers/sound/ad1848.c Sat Aug 24 23:20:58 2002
> @@ -3058,7 +3058,7 @@
>         else
>                 printk(KERN_INFO "ad1848: Failed to initialize %s\n", 
> devname);
> 
> -       return 0;
> +       return -ENODEV;
>  }
> 
>  static int __init ad1848_isapnp_probe(struct address_info *hw_config)

This will break the isapnp probe in ad1848, the problem could possibly be 
elsewhere. You have to be a bit careful when changing the return values of 
functions in some of the older OSS code.

	Zwane

-- 
function.linuxpower.ca


