Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUAJEsJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 23:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUAJEsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 23:48:09 -0500
Received: from waste.org ([209.173.204.2]:43457 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264605AbUAJEsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 23:48:06 -0500
Date: Fri, 9 Jan 2004 22:47:22 -0600
From: Matt Mackall <mpm@selenic.com>
To: George Anzinger <george@mvista.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: kgdb cleanups
Message-ID: <20040110044722.GY18208@waste.org>
References: <20040109183826.GA795@elf.ucw.cz> <3FFF2304.8000403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFF2304.8000403@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 01:54:12PM -0800, George Anzinger wrote:
> Pavel Machek wrote:
> >Hi!
> >
> >No real code changes, but cleanups all over the place. What about
> >applying?
> >
> >Ouch and arch-dependend code is moved to kernel/kgdb.c. I'll probably
> >do x86-64 version so that is rather important.
> >
> >								Pavel
> A few comments:
> 
> I like the code seperation.  Does it follow what Amit is doing?  It would 
> be nice if Amit's version and this one could come together around this.
> 
> I don't think we want to merge the eth and regular kgdb just yet.  I would, 
> however, like to keep eth completly out of the stub.  Possibly a new module 
> which just takes care of steering the I/O to the correct place.

I've sent Amit the start of an plug interface for abstracting the
communication layer. Should be relatively painless and allow for
starting sessions on the interface of your choice.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
