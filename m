Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271144AbVBEEBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbVBEEBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 23:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271164AbVBEEBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 23:01:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:34257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271144AbVBEEBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 23:01:41 -0500
Date: Fri, 4 Feb 2005 20:01:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: ambx1@neo.rr.com (Adam Belay)
Cc: castet.matthieu@free.fr, linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [patch] ns558 bug
Message-Id: <20050204200133.53d77c08.akpm@osdl.org>
In-Reply-To: <20050205034832.GC7998@neo.rr.com>
References: <4203D476.4040706@free.fr>
	<20050205004311.GA7998@neo.rr.com>
	<20050204190614.6cfd68ce.akpm@osdl.org>
	<20050205030813.GB7998@neo.rr.com>
	<20050204192115.65ea246a.akpm@osdl.org>
	<20050205034832.GC7998@neo.rr.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ambx1@neo.rr.com (Adam Belay) wrote:
>
>  As a more general solution for all drivers, I've been thinking about doing
>  something like this in the long term.
> 
>  int ret;
>  if (!(ret = register_driver(&ns558_driver)))
>  	return ret;
>  add_driver_protocol(&ns558_driver, &ns558_pnp);
>  add_driver_protocol(&ns558_driver, &ns558_isa);
> 
>  and then on exit:
> 
>  unregister_driver(&ns558_driver); /* this tears down any successfully
>  				     registered bus protocol automatically */
> 
> 
>  For now a less invasive solution might be better.

Well the thing oopses the kernel at present.  Your call, Adam.  Something
to make it work acceptably for now would suit.
