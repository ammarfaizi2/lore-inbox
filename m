Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWBVSKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWBVSKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWBVSKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:10:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51359 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1161258AbWBVSKY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:10:24 -0500
Date: Wed, 22 Feb 2006 18:10:10 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       David Zeuthen <david@fubar.dk>, Kay Sievers <kay.sievers@suse.de>,
       Pekka J Enberg <penberg@cs.Helsinki.FI>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222181010.GE27946@ftp.linux.org.uk>
References: <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI> <20060222152743.GA22281@vrfy.org> <Pine.LNX.4.64.0602220737170.30245@g5.osdl.org> <1140625103.21517.18.camel@daxter.boston.redhat.com> <Pine.LNX.4.64.0602220848280.30245@g5.osdl.org> <20060222175131.GC27946@ftp.linux.org.uk> <20060222175506.GA21080@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222175506.GA21080@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 05:55:06PM +0000, Christoph Hellwig wrote:
> On Wed, Feb 22, 2006 at 05:51:31PM +0000, Al Viro wrote:
> > What got broken?  Code that used to assume that sd.c will never, ever handle
> > openly RBC disks.  As long as that remained true, userland could assume that
> > "sd fodder" and "has type 0" were the same.  Which was never guaranteed.
> 
> sd also has been handling TYPE_MOD forever, which HAL still doesn't deal
> with.  Not that it should care at all about the scsi command type as
> you mentioned..

Oh, right - magneto-optical is also there.  I suspect that HAL doesn't
really care, along the lines of "they are all removable anyway"...
