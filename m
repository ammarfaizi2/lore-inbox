Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVHMBjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVHMBjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 21:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVHMBjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 21:39:18 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:21065 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbVHMBjR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 21:39:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ClSRlZEXXE/sPrVAqnyuT2ujpZCTqwyH7W9gRiZVKUy2VQ7X9A/rsWC+9PHBbdvxPnwaXJ1sJfsTNuo/ShgKVSnYgY0b3pz5jhli12YJ3/9YvBgaQlkLA+zyzWyPcon2yOKnAnB5WcDxVQkNiyPUcEJD+rKJCJhbZJy28yVQudk=
Message-ID: <7f45d939050812183911812222@mail.gmail.com>
Date: Fri, 12 Aug 2005 18:39:13 -0700
From: Shaun Jackman <sjackman@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Trouble shooting a ten minute boot delay (SiI3112)
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0508122113510.16845@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7f45d939050809163136a234a@mail.gmail.com>
	 <42FC0DD4.9060905@gmail.com>
	 <7f45d93905081201001a51d51b@mail.gmail.com>
	 <42FC57EC.2060204@pobox.com>
	 <7f45d93905081210441e209e31@mail.gmail.com>
	 <Pine.LNX.4.61.0508122039390.16845@yvahk01.tjqt.qr>
	 <7f45d93905081212087ea5910a@mail.gmail.com>
	 <Pine.LNX.4.61.0508122113510.16845@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/8/12, Jan Engelhardt <jengelh@linux01.gwdg.de>:
> >I tried earlyprintk=vga, but it didn't provide any extra information.
> >Although, CONFIG_EARLY_PRINTK is disabled in my .config. Does it need
> >to be set to CONFIG_EARLY_PRINTK=y for earlyprintk=vga to work?
> 
> I think yes, otherwise there would not be a .config entry at all.
> 
> >I haven't tried Sysrq+T yet. I'll report back.
> 
> Mind that it is unlikely to get a good trace at this stage, but it's worth the
> try.

I compiled a vanilla 2.6.12.4 kernel, enabled EARLY_PRINTK and
rebooted with earlyprintk=vga. The kernel didn't display any extra
information before the delay.

$ uname -a
Linux quince 2.6.12.4 #1 Fri Aug 12 13:02:40 PDT 2005 i686 GNU/Linux
$ cat /proc/cmdline
root=/dev/md0 ro nodma earlyprintk=vga
$ grep EARLY_PRINTK /boot/config-2.6.12.4
CONFIG_EARLY_PRINTK=y

I tried Alt-SysRq-T but there was no response. SYSRQ is enabled.
$ grep SYSRQ /boot/config-2.6.12.4
CONFIG_MAGIC_SYSRQ=y

Cheers,
Shaun
