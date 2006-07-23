Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWGWThD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGWThD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 15:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWGWThD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 15:37:03 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:51431 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751276AbWGWThB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 15:37:01 -0400
Message-ID: <1153683377.44c3cfb146443@portal.student.luth.se>
Date: Sun, 23 Jul 2006 21:36:17 +0200
From: ricknu-0@student.ltu.se
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se> <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Jan Engelhardt <jengelh@linux01.gwdg.de>:

> 
> >Hopefully it is now ready for a "real" patch, whom adds bool to all
> >arches. If there is no comments on this one, it will be sent about
> >tomorrow night (GMT).
> 
> --- a/drivers/block/DAC960.h
> +++ b/drivers/block/DAC960.h
> @@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
>    Define a Boolean data type.
>  */
>  
> -typedef enum { false, true } __attribute__ ((packed)) boolean;
> +typedef bool boolean;
>  
>  
>  /*
> 
> Looks good. (I know found out what this is good for. Eventually, all
> booleans
> in the source of DAC960 et al. should be changed to just 'bool' but that's
> another patch's job.)

Yepp :)

> Looks good, except for the "all arches" thing. You only seem to add it
> to i386:

I said: 'ready for a "real" patch', meaning it will be in another patch.
Will try to be more clear in the future.

> >+#undef false
> >+#undef true
> >+
> >+enum {
> >+	false	= 0,
> >+	true	= 1
> >+};
> >+
> >+#define false false
> >+#define true true 
> 
> Can someone please tell me what advantage 'define true true' is going to
> bring, besides than being able to '#ifdef true'?

Assembly-code can not use enum but #define. That is the reason I find but there
might be more.


> Jan Engelhardt

/Richard Knutsson

