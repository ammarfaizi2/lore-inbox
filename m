Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271318AbTHHM4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 08:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271317AbTHHM4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 08:56:53 -0400
Received: from mayhem.byteworld.com ([63.127.169.21]:51368 "EHLO
	chaos.byteworld.com") by vger.kernel.org with ESMTP id S271307AbTHHM4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 08:56:02 -0400
Date: Fri, 8 Aug 2003 08:56:04 -0400
From: William Enck <wenck@wapu.org>
To: "Nicolas P." <linux@1g6.biz>
Cc: linux-kernel@vger.kernel.org, David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: orinoco_cs: RequestIRQ: Unsupported mode
Message-ID: <20030808125604.GA22090@chaos.byteworld.com>
References: <20030808031706.GB20401@chaos.byteworld.com> <200308080829.04842.linux@1g6.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308080829.04842.linux@1g6.biz>
User-Agent: Mutt/1.3.28i
X-Sent-From: chaos.byteworld.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added CONFIG_ISA=y to my -mm5 config and it worked. 

Thanks Nicolas.

Will

On Fri, Aug 08, 2003 at 08:29:04AM +0200, Nicolas P. wrote:
> 
> Did you try to switch on  :
> 
> CONFIG_ISA=y
> 
> I had the same problem on 2.6.0-test2 (it is not your
> case but who knows ?), and now it works for me.
> It doesn't come from the driver as the hostap one did
> the same error.
> 
> Nicolas.
> 
> 
> 
> Le Vendredi 8 Ao?t 2003 05:17, William Enck a ?crit :
> > dmesg outputs the following
> >
> > orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> > orinoco_cs: RequestIRQ: Unsupported mode
> >
> > It does that in 2.6.0-test2-(bk7|bk7-netdrvr1|mm5).
> >
> > It functions correctly in 2.6.0-test2 and -mm4.
> >
> > Attached is my config for 2.6.0-test2-mm5 as well as mm4-mm5_config.diff
> > which is a diff -u on the two .config's used.
> >
> > Also, I just noticed that dmesg produces:
> > orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
> > orinoco_cs: Unknown parameter `8200'
> >
> > But it is in the dmesg output of both mm4 and mm5
> >
> > Let me know if anything else is needed to try to figure out what happend
> > between -mm4 and -mm5
> >
> > Will
> 
> 
> >Hi,
> >
> >I compiled the kernel with ISA support !
> >and it worked well, strange but it worked ...
> >
> >But now, since few days I am using the hostap driver
> >(which had the same problem RequestIRQ without ISA,
> >so it is not related to orinoco but more to irq stuffs in the kernel),
> >
> >so no more tests with the orinoco, sorry ...
> >
> >Bye.
> >
> >Nicolas.
> 
> Le Vendredi 1 Ao?t 2003 11:38, vous avez ?crit :
> > On Tue, Jul 29, 2003 at 11:30:18AM +0200, Nicolas P. wrote:
> > > Hi,
> > >
> > > on kernels 2.6.0-test[12],
> > > I have this message : orinoco_cs: RequestIRQ: Resource in use,
> > > on toshiba tecra 8100 (pcmcia netgear MA401 / 802.11b)
> > > The driver works well on 2.4.xx
> >
> > How odd.  It also seems to work for me on 2.5.75, but I've heard
> > several reports of problems on 2.6.0-test.  Unfortunately I'm overseas
> > at the moment and don't really have time to investigate.  I'll be back
> > around the 20th of August, if you remind me then I'll investigate
> > further.
> >
> > At first blush this looks like a problem in the PCMCIA layer though -
> > it's refusing our request for an interrupt for unclear reasons.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
William Enck
wenck@wapu.org
