Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWF2Xhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWF2Xhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWF2Xhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:37:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42203 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751314AbWF2Xhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:37:41 -0400
Date: Thu, 29 Jun 2006 16:40:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: gregoire.favre@gmail.com, linux-kernel@vger.kernel.org,
       davej@codemonkey.org.uk, kraxel@suse.de
Subject: Re: 2.6.17-mm4 undefined reference to `alternatives_smp_module_del'
Message-Id: <20060629164054.3b2e07d4.akpm@osdl.org>
In-Reply-To: <44A46130.8090102@keyaccess.nl>
References: <20060629122721.GA18671@gmail.com>
	<20060629154247.1bf8eccf.akpm@osdl.org>
	<44A46130.8090102@keyaccess.nl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman <rene.herman@keyaccess.nl> wrote:
>
> Andrew Morton wrote:
> 
> > <looks at davej>
> > 
> > That patch is pretty yuk anyway
> > 
> >  void module_arch_cleanup(struct module *mod)
> >  {
> > +#ifdef CONFIG_SMP
> > 	alternatives_smp_module_del(mod);
> > +#endif
> >  }
> > 
> > Should be a stub in a header file, which would fix this problem too.
> 
> Gerd Hoffmann already did this and I suppose it's in some upstream tree 
> somewhere:

I'd say it got lost.

> http://marc.theaimsgroup.com/?l=linux-kernel&m=114743413932319&w=2
> 

<snarf>

Thanks.
