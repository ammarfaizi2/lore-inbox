Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279893AbRJ3H4p>; Tue, 30 Oct 2001 02:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279894AbRJ3H4f>; Tue, 30 Oct 2001 02:56:35 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:44193
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S279893AbRJ3H4Q>; Tue, 30 Oct 2001 02:56:16 -0500
From: arjan@fenrus.demon.nl
To: sam@vilain.net (Sam Vilain)
Subject: Re: eepro100 quirk with APM suspend on Dell laptops
cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15yQd9-0005Rm-00@hoffman.vilain.net>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E15yTkh-0001hc-00@fenrus.demon.nl>
Date: Tue, 30 Oct 2001 07:56:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15yQd9-0005Rm-00@hoffman.vilain.net> you wrote:
> Hi there,

> And to the resume action:

>  setpci -s8:4 4=17 5=1 c=8 d=20 11=f0 12=ff 13=fb \
>               14=c1 15=dc 1a=e0 1b=fb 33=fc 3c=b
>  ifup eth0

> Is this a job for `PCI hotplug', a eepro100 driver bug, or something else?

For the Red Hat Linux kernel we added a quirk for this machine that restores
PCI config space on restore, so that this is no longer needed. It's kind of
a hack so I haven't sent it to Linus for merging yet....
