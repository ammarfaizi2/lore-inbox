Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDHBmJ>; Sat, 7 Apr 2001 21:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132396AbRDHBl6>; Sat, 7 Apr 2001 21:41:58 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:48393 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132387AbRDHBls>; Sat, 7 Apr 2001 21:41:48 -0400
Message-Id: <200104080141.f381fhs92169@aslan.scsiguy.com>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 and 2.4.4-pre1 
In-Reply-To: Your message of "Sun, 08 Apr 2001 02:22:33 +0200."
             <20010408022233.E1138@werewolf.able.es> 
Date: Sat, 07 Apr 2001 19:41:43 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>NORET_TYPE void panic(const char * fmt, ...)
>    __attribute__ ((NORET_AND format (printf, 1, 2)));
>                    ^^^^^^^^^
>
>Similar cases, compare include/linux/raid/md_k.h:pers_to_level() in
>2.4.3 and 2.4.3-ac3.

Then gcc is not honoring the attribute.  The only way for that
function to not return with a value is in the panic case and that
cannot happen.

--
Justin
