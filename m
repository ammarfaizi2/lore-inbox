Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270346AbTHGRcT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 13:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTHGRcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 13:32:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:27572 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270346AbTHGRcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 13:32:18 -0400
Date: Thu, 7 Aug 2003 10:34:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: jcwren@jcwren.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.0-test2 vs 2.2.12 -- Some observations
Message-Id: <20030807103413.5625235e.akpm@osdl.org>
In-Reply-To: <200308071323.44884.jcwren@jcwren.com>
References: <1060256649.3169.20.camel@dhcp22.swansea.linux.org.uk>
	<Pine.LNX.4.44.0308071023040.6818-200000@logos.cnet>
	<20030807142624.GA29208@lst.de>
	<200308071323.44884.jcwren@jcwren.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.C. Wren" <jcwren@jcwren.com> wrote:
>
> Interactive performance is an atrocity with 2.6.0-test2.  Something as simple 
>  as backspacing though a command line can cause overrun errors.  Whereas 
>  before zmodeming a file down was not an issue with 2.2.12 (this, in fact, is 
>  how software is applied to the CF card), it fails completely under 
>  2.6.0-test2.

It sounds like something is spinning in-kernel.

What do `free' and `cat /proc/meminfo' and `top' say?

The next step would be to generate a kernel profile.
