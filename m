Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRINWVW>; Fri, 14 Sep 2001 18:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271344AbRINWVN>; Fri, 14 Sep 2001 18:21:13 -0400
Received: from 65-45-81-178.customer.algx.net ([65.45.81.178]:36340 "EHLO
	postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S271108AbRINWVE> convert rfc822-to-8bit; Fri, 14 Sep 2001 18:21:04 -0400
Date: Fri, 14 Sep 2001 15:06:55 -0700 (PDT)
From: "John D. Kim" <johnkim@aslab.com>
To: hugang <linuxbest@soul.com.cn>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: A patch for dhcp and nfsroot.
In-Reply-To: <20010914085103.493e30b1.linuxbest@soul.com.cn>
Message-ID: <Pine.LNX.4.31.0109141503020.32576-100000@postbox.aslab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmmm...  I've tried the patch with 2.4.8, 2.4.8-ac12, and 2.4.9-ac8.  All
three says "couldn't find the kernel version the module was compiled for"
when insmod tries to load the ipconfig module.  I've also tried different
versions of insmod(2.4.0, 2.4.2, and 2.4.8).  I have not yet tried your
kernel yet since I'm working with pcmcia devices, but I'll give it a try
as well, just to see if ipconfig would load or not.

Anyone else here have a clue?

On Fri, 14 Sep 2001, hugang wrote:

> On Thu, 13 Sep 2001 10:47:18 -0700 (PDT)
> "John D. Kim" <johnkim@aslab.com> wrote:
> >Hi hugang.  This came just in time to fix a problem I'm having.  But when
> >I try to load it using insmod, it complains that it cannot find the kernel
> >it was built for.  Have you got this working successfully?  Which kernel
> >are you running?  I'm running 2.4.9-ac8.
> >
> >I'm also using this in an initrd setting.  I'm trying to load the kernel
> >and the initrd image, have the ipconfig modules get stuff through dhcp and
> >then nfsroot.  Can you think of what might be causing this problem?  I'm
> >no kernel hacker, but I'll do what I can.
> >
> >
> >
> Thanks for test it.
>
> Yes,it work in my labs with kernel 2.4.8 (not ac)! I use it for an linux disaster recovery solution.
>
> It your still can use it , I put my use kernel in http://www.soul.com.cn/2.4.9/2.4.9-disaster.tar.bz2
>
> /boot/vmlinu.gz  	kernel
> /boot/initrd.img.gz	initrd.img
> /lib/module		kernel modules.
>
> Beacuse my netcard can not remote boot, I use grub .
> In grub command:
>
> bootp
> root (nd)
> kernel vmlinuz.gz root=/dev/nfs
> initrd initrd.img.gz
>
> I test it with eepro100 netcard.I thinks it can work with another net card.
>
>
> --
> Best Regard!
> 礼！
> ----------------------------------------------------
> hugang : 胡刚 	GNU/Linux User
> email  : gang_hu@soul.com.cn linuxbest@soul.com.cn
> Tel    : +861068425741/2/3/4
> Web    : http://www.soul.com.cn
>
> 	Beijing Soul technology Co.Ltd.
> 	   北京众志和达科技有限公司
> ----------------------------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

