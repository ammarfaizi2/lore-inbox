Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUC2IxB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 03:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUC2IxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 03:53:01 -0500
Received: from mail.sam-solutions.net ([217.21.35.41]:38880 "EHLO
	mail.belcaf.minsk.by") by vger.kernel.org with ESMTP
	id S262781AbUC2Iwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 03:52:54 -0500
Date: Mon, 29 Mar 2004 12:45:42 +0300
From: Pavel Mironchik <p.mironchik@sam-solutions.net>
To: karim@opersys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel / Userspace Data Transfer
Message-Id: <20040329124542.019edd8b.p.mironchik@sam-solutions.net>
In-Reply-To: <406799F3.1020508@opersys.com>
References: <1080528430.40678e2e9eb3a@www.beonline.com.au>
	<406799F3.1020508@opersys.com>
Organization: Sam-Solutions
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The best Userspace-kernelspace-Userspace transfer thing is soket.
Unix or TCP/UDP sockets API is avaible from kernel space.
You should use it...

Pavel Mironchik


On Sun, 28 Mar 2004 22:37:23 -0500
Karim Yaghmour <karim@opersys.com> wrote:

> 
> lml@beonline.com.au wrote:
> > I have a set of counters in a Kernel module that i want to export to a
> > userspace application. I originally decided to use a /proc entry and parse
> > the output whenever the userspace application needed this data, however,
> > i need more than the 4096 that is allowed in /proc and i'm not too keen
> > on parsing large chunks of text anyway.
> > 
> > What i would like to do is copy these slabs of text from the kernel to my
> > userspace application (whenever the application requests it). I've seen the
> > 'copy_to_user' function and it looks usefull, but have no idea where to start
> > or how to use it :-/
> > 
> > Can someone provide and example or point me in the right direction? Or is there
> > a better place to ask this question?
> 
> relayfs has been designed with this type of requirements in mind:
> http://www.opersys.com/relayfs/index.html
> 
> Karim
> -- 
> Author, Speaker, Developer, Consultant
> Pushing Embedded and Real-Time Linux Systems Beyond the Limits
> http://www.opersys.com || karim@opersys.com || 1-866-677-4546
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
