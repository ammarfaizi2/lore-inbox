Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbTADAGO>; Fri, 3 Jan 2003 19:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267724AbTADAGO>; Fri, 3 Jan 2003 19:06:14 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:61593 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267721AbTADAGN>; Fri, 3 Jan 2003 19:06:13 -0500
Message-ID: <3E162714.F721786F@us.ibm.com>
Date: Fri, 03 Jan 2003 16:13:08 -0800
From: Nivedita Singhvi <niv@us.ibm.com>
Reply-To: niv@us.ibm.com
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: riel@conectiva.com.br
CC: linux-kernel@vger.kernel.org
Subject: Re: [STUPID] Best looking code to transfer to a t-shirt
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

Thanks for posting this, it was truly hilarious and a joy to behold :)

A reminder of the best on this planet, after observing the ugliest 
and worst on this planet a short while ago on this mailing list..

thanks,
Nivedita

> How about drivers/net/sunhme.c ?
> 
> It's not scary, but it is absolutely hilarious, even to
> people who don't even know C.
> 
> static void happy_meal_tcvr_write(struct happy_meal *hp,
>                                   unsigned long tregs, int reg,
>                                   unsigned short value)
> {
>         int tries = TCVR_WRITE_TRIES;
> 
>         ASD(("happy_meal_tcvr_write: reg=0x%02x value=%04x\n", reg,
> value));
> 
>         /* Welcome to Sun Microsystems, can I take your order please? */
>         if (!hp-&gt;happy_flags &amp; HFLAG_FENABLE)
>                 return happy_meal_bb_write(hp, tregs, reg, value);
> 
>         /* Would you like fries with that? */
>         hme_write32(hp, tregs + TCVR_FRAME,
>                     (FRAME_WRITE | (hp-&gt;paddr &lt;&lt; 23) |
>                      ((reg &amp; 0xff) &lt;&lt; 18) | (value &amp; 0xffff)));
>         while (!(hme_read32(hp, tregs + TCVR_FRAME) &amp; 0x10000) &amp;&amp; --tries)
>                 udelay(20);
> 
>         /* Anything else? */
>         if (!tries)
>                 printk(KERN_ERR "happy meal: Aieee, transceiver MIF write
> bolixed\n");
> 
>         /* Fifty-two cents is your change, have a nice day. */
> }
> 
> 
> Rik
