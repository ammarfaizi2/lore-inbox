Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWI3RF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWI3RF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWI3RF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:05:57 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:63752 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750827AbWI3RF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:05:56 -0400
Date: Sat, 30 Sep 2006 18:05:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhylands@gmail.com, guinan@bluebutton.com, linux-kernel@vger.kernel.org
Subject: Re: get_user_pages() cache issues on ARM
Message-ID: <20060930170548.GA24949@flint.arm.linux.org.uk>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, dhylands@gmail.com,
	guinan@bluebutton.com, linux-kernel@vger.kernel.org
References: <E1GTiBq-0002i3-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1GTiBq-0002i3-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2006 at 06:59:50PM +0200, Miklos Szeredi wrote:
> Hi Russell,
> 
> The get_user_pages() vs dcache coherency issue still seems to be
> unresolved on ARM.
> 
> See flush_anon_page() and flush_kernel_dcache_page() in
> Documentation/cachetlb.txt and their implementation on PARISC.
> 
> Can you please take a look at this?

I'm sorry, I don't think I have sufficient understanding of the Linux VM
to look at these issues anymore.

The questions I have are:

- where do these pages that get_user_pages() finds and calls flush_anon_page()
  on come from?
- why is the current ARM flush_dcache_page() (which is also called after
  flush_anon_page()) not sufficient?
- if we implement flush_anon_page() does that mean that we end up flushing
  multiple times in some circumstances?  If so, how do we avoid this?

I'm really serious - I no longer understand the Linux VM sufficiently to
get this stuff right.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
