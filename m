Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263950AbUCZHQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 02:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263658AbUCZHQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 02:16:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:40458 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263950AbUCZHQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 02:16:05 -0500
Date: Fri, 26 Mar 2004 07:15:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: mike.miller@hp.com
Cc: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6
Message-ID: <20040326071556.A2637@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mike.miller@hp.com,
	akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
References: <20040325224641.GE4456@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040325224641.GE4456@beardog.cca.cpqcorp.net>; from mike.miller@hp.com on Thu, Mar 25, 2004 at 04:46:41PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 04:46:41PM -0600, mike.miller@hp.com wrote:
> Please consider this patch for inclusion in the 2.6 kernel.
> 
> If no device is attached we now return -ENXIO instead of some bogus numbers.
> Prevents applications from trying to access non-existent disks.
> Also adds HDIO_GETGEO_BIG IOCTL that fdisk uses.

HDIO_GETGEO_BIG was only used by some horribly patched vendor fdisks.
It's not declared in the kernel, and thus no driver should implement it.

