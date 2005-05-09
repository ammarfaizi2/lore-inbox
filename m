Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVEIPTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVEIPTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVEIPTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:19:20 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:25053 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261418AbVEIPTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:19:16 -0400
In-Reply-To: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
       Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "<cpclark@xmission.com> <cpclark@xmission.com>" 
	<cpclark@xmission.com>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: PPC uImage build not reporting correctly
Date: Mon, 9 May 2005 10:19:01 -0500
To: Sam Ravnborg <sam@ravnborg.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:

> On Fri, 6 May 2005, Kumar Gala wrote:
>  > I tried the following w/o success:
>  >
> > $(obj)/uImage: $(obj)/vmlinux.gz
> >         $(Q)rm -f $@
>  >         $(call if_changed,uimage)
> >         @echo '  Image: $@' $(shell if [ -f $@ ]; then echo 'is 
> ready'; else
>  > echo 'not made'; fi)
>
> Couldn't you eliminate the ($shell ..) construct altogether, like 
> this?:
>
> $(obj)/uImage: $(obj)/vmlinux.gz
>         $(Q)rm -f $@
>          $(call if_changed,uimage)
>         @echo -n '  Image: $@'
>          @if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi

Yes, and this seems to actually work.

Sam, does this look reasonable to you.  If so I will work up a patch.

thanks

- kumar

