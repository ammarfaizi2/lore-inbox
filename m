Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265205AbUF1U7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUF1U7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUF1U7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:59:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:7143 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265205AbUF1U7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:59:44 -0400
Date: Mon, 28 Jun 2004 13:57:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: pfg@sgi.com, erikj@subway.americas.sgi.com, cw@f00f.org, hch@infradead.org,
       jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Altix serial driver
Message-Id: <20040628135720.369676f4.akpm@osdl.org>
In-Reply-To: <20040628204707.D9214@flint.arm.linux.org.uk>
References: <Pine.SGI.4.53.0406280719080.581376@subway.americas.sgi.com>
	<Pine.SGI.3.96.1040628140341.36430F-100000@fsgi900.americas.sgi.com>
	<20040628121312.75ac9ed7.akpm@osdl.org>
	<20040628204707.D9214@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> > It does sound to me like some work is needed in the generic serial layer to
>  > teach it to get its sticky paws off the ttyS0 major/minor if there is no
>  > corresponding hardware.
> 
>  It isn't that simple.

Is it ever?

I realise now I don't understand the problem ;) The altix serial driver
comes up, does register_console() and then stuff gets sent to /dev/console.

Who needs to know the driver's major/minor, and why?
