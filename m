Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423161AbWJZD72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423161AbWJZD72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 23:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423155AbWJZD72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 23:59:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2735 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423135AbWJZD70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 23:59:26 -0400
Date: Wed, 25 Oct 2006 20:59:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: proski@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: incorrect taint of ndiswrapper
Message-Id: <20061025205923.828c620d.akpm@osdl.org>
In-Reply-To: <1161808227.7615.0.camel@localhost.localdomain>
References: <1161807069.3441.33.camel@dv>
	<1161808227.7615.0.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 25 Oct 2006 21:30:26 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Mer, 2006-10-25 am 16:11 -0400, ysgrifennodd Pavel Roskin:
> > I don't see any legal reasons behind this restriction.  A driver under
> > GPL should be able to use any exported symbols.  EXPORT_SYMBOL_GPL is a
> > technical mechanism of enforcing GPL against non-free code, but
> > ndiswrapper is free.  The non-free NDIS drivers are not using those
> > symbols.
> 
> The combination of GPL wrapper and the NDIS driver as a work is not free
> (in fact its questionable if its even legal to ship such a combination
> together).

May be so.  But this patch was supposed to print a helpful taint message to
draw our attention to the fact that ndis-wrapper was in use.  The patch was
not intended to cause gpl'ed modules to stop loading (or if is was, that
effect was concealed from yours truly).

IOW, this was a mistake.


Now, if we do want to disallow gpl module loading after ndis-wrapper has
been used then fine, we can discuss that.  If we decide to proceed that way
then we will probably cause a load of ndis-wrapper to emit a scary printk for
six months or so to give people time to make arrangements.
