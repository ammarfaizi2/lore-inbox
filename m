Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUG2Fxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUG2Fxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 01:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUG2Fxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 01:53:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:63125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264286AbUG2Fxl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 01:53:41 -0400
Date: Wed, 28 Jul 2004 22:51:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mke2fs -j goes nuts on 3Ware 8506-4LP
Message-Id: <20040728225146.69748f52.akpm@osdl.org>
In-Reply-To: <200407281050.24958.m.watts@eris.qinetiq.com>
References: <200407281050.24958.m.watts@eris.qinetiq.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts <m.watts@eris.qinetiq.com> wrote:
>
> I have a 3Ware 8506-4LP controller with 4 250GB Maxtor SATA drives, in a 
>  raid-5 configuration (64K blocks)
>  System is:
>  Dual Opteron 246 (2GHz)
>  2GB RAM
>  Tyan S2875 motherboard
> 
>  Kernel: 2.6.8-rc2 (pre-empt is ON)
>  Rest of OS: Mandrake 10.0 AMD64 edition.
> 
>  When I execute a mke2fs -j /dev/sda7  to format a 600GB partition on the raid 
>  as ext3, the system slows to a crawl.

It's conceivably a memory reclaim problem.  Please try booting with the
boot command line option `mem=768M', then see if it goes any better.
