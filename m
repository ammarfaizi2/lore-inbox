Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWBJWbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWBJWbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWBJWbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:31:06 -0500
Received: from atpro.com ([12.161.0.3]:31756 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1751388AbWBJWbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:31:05 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Fri, 10 Feb 2006 17:30:53 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1
Message-ID: <20060210223053.GF11297@voodoo>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060207220627.345107c3.akpm@osdl.org> <20060210213058.GE11297@voodoo> <43ED1390.40809@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ED1390.40809@pobox.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/06 05:28:32PM -0500, Jeff Garzik wrote:
> Jim Crilly wrote:
> >On 02/07/06 10:06:27PM -0800, Andrew Morton wrote:
> >
> >>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc2/2.6.16-rc2-mm1/
> >>
> >
> >
> >I got the following BUG with the tulip driver because there's a mdelay(1)
> >at the end of the tulip_media_select() function. Removing the mdelay(1)
> >is trivial so I've attached a patch, but I'm not sure if it's the
> >correct fix so I've CC'd Jeff Garzik.
> >
> >BUG: warning at drivers/net/tulip/media.c:402/tulip_select_media()
> ><f0c8e288> tulip_select_media+0x7b8/0x7db [tulip]   <b02103ac> 
> >dma_pool_free+0xc4/0x10e
> ><f0c9130b> t21142_lnk_change+0x1af/0x4f4 [tulip]   <f0c7c490> 
> >finish_urb+0x98/0xc0 [ohci_hcd]
> ><f0c8d374> tulip_interrupt+0x65f/0x803 [tulip]   <f0c7e153> 
> >ohci_irq+0x148/0x16d [ohci_hcd]
> ><b013cb3f> handle_IRQ_event+0x20/0x4c   <b013cbf7> __do_IRQ+0x8c/0xdd
> ><b0105250> do_IRQ+0x3c/0x54
> >  =======================
> ><b0103662> common_interrupt+0x1a/0x20   <b0101aa6> default_idle+0x0/0x55
> ><b0101ad2> default_idle+0x2c/0x55   <b0101b8a> cpu_idle+0x8f/0xae
> ><b02f8707> start_kernel+0x37f/0x386
> >
> >Signed-off-by: Jim Crilly <jim@why.dont.jablowme.net>
> 
> Its wrong, and further we don't need obvious spam email addresses in the 
> changelog.
> 
> 	Jeff

My apologies then, but the address isn't a spam address.

Jim.
