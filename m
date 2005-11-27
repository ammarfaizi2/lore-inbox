Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbVK0TLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbVK0TLz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbVK0TLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:11:55 -0500
Received: from hera.kernel.org ([140.211.167.34]:52616 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750834AbVK0TLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:11:53 -0500
Date: Sun, 27 Nov 2005 11:28:25 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       markus.lidel@shadowconnect.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark Salyzyn <mark_salyzyn@adaptec.com>
Subject: Re: [patch] drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference
Message-ID: <20051127132825.GB21383@logos.cnet>
References: <20051126233637.GC3988@stusta.de> <20051127124738.GC13581@logos.cnet> <20051127185252.GG3988@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051127185252.GG3988@stusta.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 07:52:52PM +0100, Adrian Bunk wrote:
> On Sun, Nov 27, 2005 at 10:47:38AM -0200, Marcelo Tosatti wrote:
> > On Sun, Nov 27, 2005 at 12:36:37AM +0100, Adrian Bunk wrote:
> > > The Coverity checker spotted this obvious NULL pointer dereference.
> > 
> > Hi Adrian,
> 
> Hi Marcelo,
> 
> > Could you explain why you remove the adpt_post_wait_lock acquision? 
> > 
> > And if it does not belong there, why don't you remove it instead of
> > commeting out?
> >...
> 
> my patch does remove the following not required line:
> 
> > > -	p2 = NULL;
> 
> It does not touch the following line that was already commented out:
> 
> > >  //	spin_lock_irqsave(&adpt_post_wait_lock, flags);
> >...

Doh. I should _read_ the patch. 

