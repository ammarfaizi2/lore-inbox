Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVAUIC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVAUIC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAUIC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:02:28 -0500
Received: from mail.kroah.org ([69.55.234.183]:8171 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261395AbVAUH7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:59:18 -0500
Date: Thu, 20 Jan 2005 23:58:33 -0800
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: John Mock <kd6pag@qsl.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1 vs. PowerMac 8500/G3 (and VAIO laptop) [usb-storage oops]
Message-ID: <20050121075833.GA19995@kroah.com>
References: <E1CrPQ4-0000pW-00@penngrove.fdns.net> <1106210408.6932.27.camel@localhost.localdomain> <20050121000822.GA14580@kroah.com> <1106293748.783.31.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106293748.783.31.camel@baythorne.infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 07:49:08AM +0000, David Woodhouse wrote:
> On Thu, 2005-01-20 at 16:08 -0800, Greg KH wrote:
> > Doh, sorry for missing this one.  I've applied your patch to my trees,
> > and will show up in the next -mm release.
> 
> Actually I think John's problem was that the usb core code has now
> _stopped_ doing this byteswapping, and he has a lsusb which is hacked to
> expect it. So if you apply my patch you're preserving the userspace ABI
> by reverting to the extremely stupid behaviour of byteswapping _some_ of
> the fields in the descriptor we pass to userspace.

Well, we should be byteswapping all of the fields that need to be
swapped, right?  I'm guessing that userspace is expecting the fields to
be in cpu endian, correct?

But if you want, I'll gladly revert your patch, as I don't have a ppc
box to test this out on.

thanks,

greg k-h
