Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263104AbVF3XGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbVF3XGU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVF3XGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 19:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263104AbVF3XGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 19:06:14 -0400
Date: Thu, 30 Jun 2005 16:05:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: ocroquette@free.fr, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: setitimer expire too early (Kernel 2.4)
Message-Id: <20050630160537.7d05d467.akpm@osdl.org>
In-Reply-To: <20050630165053.GA8220@logos.cnet>
References: <42C444AA.2070508@free.fr>
	<20050630165053.GA8220@logos.cnet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> On Thu, Jun 30, 2005 at 09:14:50PM +0200, Olivier Croquette wrote:
> > 
> > I am refering to this bug:
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=4569
> > 
> > A thread led to a patch from Paulo:
> > 
> > http://kerneltrap.org/mailarchive/1/message/59454/flat
> > 
> > This patch has been included in the kernel 2.6.12.
> > 
> > 1. How can I easily check if the patch is planned for include in the 2.4?
> > 
> > 2. I downloaded the full 2.4.31 source code. The patch appears not to be 
> > included. Where/Who should I signal that?
> 
> And what about the side effects:
> This however will produce pathological cases, like having a idle system
> being requested 1 ms timeouts will give systematically 2 ms timeouts,
> whereas currently it simply gives a few usecs less than 1 ms. 

(20ms rather than 10ms)

> Linus, Andrew, do you consider this critical enough to be merged to 
> the v2.4 tree?

No.  I'd expect this would hurt more people than it would benefit.
