Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbUC1Nvf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 08:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUC1Nve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 08:51:34 -0500
Received: from mail.shareable.org ([81.29.64.88]:54162 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261774AbUC1Nvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 08:51:33 -0500
Date: Sun, 28 Mar 2004 14:51:24 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328135124.GA32597@mail.shareable.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40662108.40705@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> TCQ-on-write for ATA disks is yummy because you don't really know what 
> the heck the ATA disk is writing at the present time.  By the time the 
> Linux disk scheduler gets around to deciding it has a nicely merged and 
> scheduled set of requests, it may be totally wrong for the disk's IO 
> scheduler.  TCQ gives the disk a lot more power when the disk integrates 
> writes into its internal IO scheduling.

Does TCQ-on-write allow you to do ordered write commits, as with barriers,
but without needing full cache flushes, and still get good performance?

In principle I think the answer is yes, but what is the answer with
real disks in practice?

-- Jamie
