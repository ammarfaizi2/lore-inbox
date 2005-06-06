Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVFFUYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVFFUYJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbVFFUXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:23:34 -0400
Received: from animx.eu.org ([216.98.75.249]:40632 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261658AbVFFUUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 16:20:22 -0400
Date: Mon, 6 Jun 2005 16:16:14 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606201613.GA23919@animx.eu.org>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	linux-kernel@vger.kernel.org, mpm@selenic.com
References: <20050605223528.GA13726@alpha.home.local> <20050606010246.GA22252@animx.eu.org> <20050606041101.GA14799@alpha.home.local> <20050606110743.GA23107@animx.eu.org> <20050606114342.GA15757@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050606114342.GA15757@alpha.home.local>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Mon, Jun 06, 2005 at 07:07:43AM -0400, Wakko Warner wrote:
>  
> > My initramfs is passed via initrd so that I can change any aspect of it with
> > out recompiling the kernel (or maybe i could use a better understanding of
> > initramfs)  I compared bzImage to bupxImage and the savings I got was around
> > 50kb difference IIRC.
> 
> With what algo and what kernel size ?
> With the close-source upx-1.93 linked with the NRV compression, I often
> observe an average 15-20% gain on the bzImage size if it does not embed
> an initramfs. I remember that the UCL library was not as good as the NRV,
> so I've stopped using it a long time ago.

I'm using upx-ucl-beta v1.91+0.20030910cvs-2 debian package.
Command line:
upx-ucl-beta -9 -f bupxImage-2.6.12-rc6
-rw-r--r--  3 root root 618442 Jun  6 16:14 bupxImage-2.6.12-rc6
-rwxrwxrwx  1 root root 669106 Jun  6 16:14 bzImage-2.6.12-rc6*
50664 bytes savings.
the kernel I have there is 100% modular except that ramdisk is compiled in. 
It was also compiled with -Os (Optimize for size config option) using gcc
3.3.5.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
