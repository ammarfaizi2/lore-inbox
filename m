Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbULPS1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbULPS1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbULPS1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:27:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:52642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261972AbULPS1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:27:41 -0500
Date: Thu, 16 Dec 2004 10:26:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: alan@lxorguk.ukuu.org.uk, ak@suse.de, Ian.Pratt@cl.cam.ac.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-Id: <20041216102652.6a5104d2.akpm@osdl.org>
In-Reply-To: <20041216140954.GA29761@wotan.suse.de>
References: <p73acsg1za1.fsf@bragg.suse.de>
	<E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
	<20041215044927.GF27225@wotan.suse.de>
	<1103155782.3585.29.camel@localhost.localdomain>
	<20041216040136.GA30555@wotan.suse.de>
	<1103201656.3804.7.camel@localhost.localdomain>
	<20041216140954.GA29761@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> And as Pavel points out first merging arch/xen and then migrating
>  into i386 and x86_64 like it was proposed sounds extremly hard and is 
>  probably not really practical. 

It will also create more patchwork and will make the the change history
more obscure and harder to follow.

It is a bit pervers to be putting something into the tree with the
intention of ripping it up and redoing it in the near future.  Why not do
it up-front and keep the change history cleaner?  From Ian's change list
and Andi's comments it doesn't look to me that this is all as much work as
people seem to be implying?


I guess if we were to go the way which Ian is proposing it would be

a) Add arch/xen

b) Spend N weeks integrating xen into arch/i386, while also separately
   maintaining arch/xen.

c) Remove arch/xen

So...  why not skip a), c) and half of b)?
