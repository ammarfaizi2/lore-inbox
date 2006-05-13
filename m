Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWEMOyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWEMOyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEMOyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:54:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28100 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751153AbWEMOyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:54:53 -0400
Date: Sat, 13 May 2006 07:51:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages. (might
 be dm related)
Message-Id: <20060513075147.423d18bd.akpm@osdl.org>
In-Reply-To: <20060513144334.GA6013@uio.no>
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<20060426204809.GA15462@uio.no>
	<20060426135809.10a37ec3.akpm@osdl.org>
	<20060513134908.GA4480@uio.no>
	<20060513073344.4fcbc46b.akpm@osdl.org>
	<20060513144334.GA6013@uio.no>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steinar H. Gunderson" <sgunderson@bigfoot.com> wrote:
>
> On Sat, May 13, 2006 at 07:33:44AM -0700, Andrew Morton wrote:
> > Well if it's the same software lineup on new hardware, one would also
> > suspect that hardware.  Is it new?
> 
> Yes, it's new. The differences aren't that big, though: The motherboard has
> been changed, and there's an extra sil3114 controller.
> 
> > Does it run other kernels OK?
> 
> 2.6.15.4 appears to be fine, but I haven't tested it enough to make sure.
> (I'm running 2.6.17-rc4 without swap now, so we'll see.)
> 
> > Does it always crash in the same manner?
> 
> Yes; consistently and in the same place after about the same amount of time.

ho-hum.  Please see if there's anything else you can do to rule out a
hardware failure, then copy dm-devel@redhat.com on the next oops report.

The stack backtrace you have there is a little surprising.  Enabling
CONFIG_FRAME_POINTER might help clear it up.  Also it'd be worth seeing if
CONFIG_DEBUG_SLAB turns up anything.

Thanks.
