Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbTDIH42 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262889AbTDIH42 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:56:28 -0400
Received: from mail.zmailer.org ([62.240.94.4]:1924 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262879AbTDIH41 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:56:27 -0400
Date: Wed, 9 Apr 2003 11:08:03 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Message-ID: <20030409080803.GC29167@mea-ext.zmailer.org>
References: <3E93A958.80107@si.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E93A958.80107@si.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 01:02:16AM -0400, Frank Davis wrote:
> All,
> 
> I wish to suggest a possible 2.6 or 2.7 feature (too late for 2.4.x and 
> 2.5.x, I believe) that I believe would be helpful. Currently, printk 
> messages are all in english, and I was wondering if printk could be 
> modified to print out user messages that are in the default language of 
> the machine. For example,

To propagate the idea further, why not have proper message catalogs,
and that way translations.  Instead of:

> printk(KERN_WARN "This driver is messed up!\n");

There would be:
  printk(KERN_WARN "1234-6789 this driver is messed up!\n")

In the old days of big iron beasts, there used to be multivolume
binders full of system messages, and their explanations.
Searching went thru those "1234-5678" strings.

There were sets of those manuals in a number of customer languages.

...
> I'm looking for a possible uniform design to make this happen, short of 
> adding a complete machine translation module to the kernel. :) Userland 
> internationalization support is already provided(I haven't personally 
> used other languages besides English, but I've seen the options), but a 
> kernel module or printk addition that handles localized kernel messages 
> seems reasonable.

Compiled in strings take up kernel space, which has better uses.
Even those code-labels take up space. If not much in kernel (in
form of e.g. 32 bit integers ?) then at least in the  dmesg  buffer.

> Thoughts, comments?
> 
> Regards,
> Frank

/Matti Aarnio
