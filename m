Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271343AbTGPXax (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271336AbTGPXaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:30:12 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:33808 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271306AbTGPX3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:29:19 -0400
Date: Thu, 17 Jul 2003 01:44:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717014410.A2026@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl> <20030716152143.6ab7d7d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030716152143.6ab7d7d3.akpm@osdl.org>; from akpm@osdl.org on Wed, Jul 16, 2003 at 03:21:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:21:43PM -0700, Andrew Morton wrote:

> > > Why do we need the 16:16 option?
> > 
> > It is not very important, but major 0 is reserved, so if userspace
> > (or a filesystem) hands us a 32-bit device number, we have to
> > split that in some way, not 0+32. Life is easiest with 16+16.
> > (Now the major is nonzero, otherwise we had 8+8.)
> > Other choices lead to slightly more complicated code.
> > 
> 
> Why would anyone hand the kernel a 32-bit device number?  They're either 16
> or 64, are they not?

The kernel has no control over what userspace comes with.
And here userspace includes filesystems.
Not all filesystems know how to come with 64 bits.

Andries

