Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVCBVZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVCBVZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVCBVZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:25:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:47276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262530AbVCBVZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:25:46 -0500
Date: Wed, 2 Mar 2005 13:25:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: marcelo.tosatti@cyclades.com, myeatman@vale-housing.co.uk,
       linux-kernel@vger.kernel.org, gene.heskett@verizon.net
Subject: Re: Problems with SCSI tape rewind / verify on 2.4.29
Message-Id: <20050302132512.5853cd3b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
References: <E7F85A1B5FF8D44C8A1AF6885BC9A0E472B886@ratbert.vale-housing.co.uk>
	<20050302120332.GA27882@logos.cnet>
	<Pine.LNX.4.61.0503022253360.9132@kai.makisara.local>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara <Kai.Makisara@kolumbus.fi> wrote:
>
> > 
>  > v2.6 also contains the same problem BTW.
>  > 
>  > Try this:
>  > 
>  > --- a/drivers/scsi/st.c.orig	2005-03-02 09:02:13.637158144 -0300
>  > +++ b/drivers/scsi/st.c	2005-03-02 09:02:20.208159200 -0300
>  > @@ -3778,7 +3778,6 @@
>  >  	read:		st_read,
>  >  	write:		st_write,
>  >  	ioctl:		st_ioctl,
>  > -	llseek:		no_llseek,
>  >  	open:		st_open,
>  >  	flush:		st_flush,
>  >  	release:	st_release,
> 
>  This change covers up the problem. The real bug is in tar.

In that case we're kinda screwed, and should change the kernel to make tar
work again.  We can send a bug report to the tar folks (good luck) and wait
a few years.

>  The first BSF did position the tape correctly although it did fail.

(what's a BSF?)

If it positioned the tape successfully, why did it claim that it failed? 
If we were to fix that up, would tar then be happy?
