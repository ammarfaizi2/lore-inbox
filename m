Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267778AbUBTGZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUBTGZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:25:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:45540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267778AbUBTGZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:25:26 -0500
Date: Thu, 19 Feb 2004 22:30:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] USB update for 2.6.3
In-Reply-To: <1077256996.20789.1091.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402192221560.2244@ppc970.osdl.org>
References: <20040220012802.GA16523@kroah.com>  <Pine.LNX.4.58.0402192156240.2244@ppc970.osdl.org>
 <1077256996.20789.1091.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> A while ago, I've advertised making this API a set of function
> pointers attached to the struct device inherited from the bus
> parent, so the core code just set one for the root PCIs and
> everybody inherits them.... But of course, since x86 isn't
> affected, nobody cared ;)

Well, in all fairness, that _is_ what "platform_data" is supposed to be. A
platform-specific pointer to whatever data structure that platform needs
to have to do the device ops. Platforms that don't need the function 
pointers wouldn't have any function pointers there, while others would 
have not just the function pointers, but could have some other 
bus-dependent data too.

(And this is what at least HP-PA does, as does ARM...)

So it's definitely not unsuitable for this. It does seem like USB jumped 
the gun a bit, though.

		Linus
