Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWHHACn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWHHACn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 20:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWHHACn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 20:02:43 -0400
Received: from ozlabs.org ([203.10.76.45]:25524 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932427AbWHHACn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 20:02:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17623.54420.461017.882242@cargo.ozlabs.ibm.com>
Date: Tue, 8 Aug 2006 10:02:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Matt Reuther <mreuther@umich.edu>,
       LKML <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>
Subject: Re: [-mm patch] add timespec_to_us() and use it in kernel/tsacct.c
In-Reply-To: <20060807132418.037048a5.akpm@osdl.org>
References: <200608062330.19628.mreuther@umich.edu>
	<20060806222129.f1cfffb9.akpm@osdl.org>
	<20060807133240.GB3691@stusta.de>
	<20060807132418.037048a5.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> On Mon, 7 Aug 2006 15:32:41 +0200
> Adrian Bunk <bunk@stusta.de> wrote:
> > This doesn't look correct since do_div() does not guarantee to return 
> > more than 32bit.
> 
> eh?  We use do_div() to do 64bit/something all the time??

Indeed.  If do_div didn't return a 64-bit quotient then
printk("%lld", ...) wouldn't work.  (The remainder is 32-bit of course,
because the divisor is 32-bit.)

Paul.

