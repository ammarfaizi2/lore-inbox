Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSIXCHf>; Mon, 23 Sep 2002 22:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSIXCHf>; Mon, 23 Sep 2002 22:07:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40454 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261528AbSIXCHe>;
	Mon, 23 Sep 2002 22:07:34 -0400
Message-ID: <3D8FC9F2.1020604@pobox.com>
Date: Mon, 23 Sep 2002 22:12:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry Kessler <kessler@us.ibm.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hien Nguyen <hien@us.ibm.com>,
       James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC} 3 of 4 - New problem logging macros, plus template
  generation
References: <3D8FC5C8.ED4D4C8@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * introduce(), problem(), and detail() macros
> + * Sample usage:
> + *	problem(LOG_ALERT, "Disk on fire!",
> + *		detail(disk, "%s", drive->name),
> + *		detail(temperature, "%d", drive->degC),
> + *		detail(action, "%s", "Put out fire; run fsck."));
> + */


action is policy, it does not belong in the kernel at all.  Further, I 
not sure we need to add all this new infrastructure when we could obtain 
the same result via [off the top of my head] printk standards in key 
drivers.

Why don't you start out with a list of requirements that you want to see 
from drivers?  Only then can we objectively evaluate our needs.

You are proposing a solution without really making it clear what 
problems you are solving.

	Jeff



