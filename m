Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBQHvk>; Sat, 17 Feb 2001 02:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129545AbRBQHvb>; Sat, 17 Feb 2001 02:51:31 -0500
Received: from linuxcare.com.au ([203.29.91.49]:36615 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129165AbRBQHv3>; Sat, 17 Feb 2001 02:51:29 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 17 Feb 2001 18:46:34 +1100
To: Rick Richardson <rickr@mn.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whats the rvmalloc() story?
Message-ID: <20010217184633.A2484@linuxcare.com>
In-Reply-To: <20010210220808.A18488@mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010210220808.A18488@mn.rr.com>; from rickr@mn.rr.com on Sat, Feb 10, 2001 at 10:08:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I note that at least 5 device drivers have similar implementations
> of rvmalloc()/rvfree() et al:
> 
> 	ieee1394/video1394.c
> 	usb/ibmcam.c
> 	usb/ov511.c
> 	media/video/bttv-driver.c
> 	media/video/cpia.c
> 
> rvmalloc()/rvfree() are functions that are used to allocate large
> amounts of physically non-contiguous kernel virtual memory that will
> then be mmap()'ed into a user process.

I had to rewrite rvmalloc and friends in the bttv driver to support the
new pci dynamic mapping interface. This sounds like a good time to clean
up all these multiple definitions.

Anton
