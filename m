Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261291AbVCPQ6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261291AbVCPQ6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 11:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262682AbVCPQ6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 11:58:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55431 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261291AbVCPQ6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 11:58:08 -0500
Date: Wed, 16 Mar 2005 08:53:12 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Martin MOKREJ?? <mmokrejs@ribosome.natur.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in	/lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
Message-ID: <20050316115312.GA12881@logos.cnet>
References: <42384AB9.1080905@ribosome.natur.cuni.cz> <1110986170.6292.20.camel@laptopd505.fenrus.org> <42384EE8.9000003@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42384EE8.9000003@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 04:21:12PM +0100, Martin MOKREJ? wrote:
> Arjan van de Ven wrote:
> >On Wed, 2005-03-16 at 16:03 +0100, Martin MOKREJ?? wrote:
> >
> >>Hi,
> >> does anyone still use 2.4 series kernel? ;)
>
> >># make dep; make bzImage; make modules
> >>[cut]
> >># make modules_install
> >>[cut]
> >>cd /lib/modules/2.4.30-pre3-bk2; \
> >>mkdir -p pcmcia; \
> >>find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} 
> >>pcmcia
> >>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  
> >>2.4.30-pre3-bk2; fi
> >>depmod: *** Unresolved symbols in 
> >>/lib/modules/2.4.28-pre2/xfree-drm/via_drv.o
> >
> >
> >this is not the module shipped by the kernel.org kernel...
> 
> Right. Sorry that I didn't say it more clearly, but I'm installing 
> 2.4.30-pre3-bk2 kernel.
> cd /usr/src/linux-2.4.30-pre3-bk2
> make dep
> make bzImage
> make modules
> make modules_install
> 
> and then I hit the error about some totally unrelated kernel version in 
> /lib/modules? :(

Martin,

Can you find out why is depmod trying to open /lib/modules/2.4.28-pre2/ ?

I've got no clue.
