Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbTLHRLX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 12:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265534AbTLHRLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 12:11:22 -0500
Received: from email-out2.iomega.com ([147.178.1.83]:4020 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265098AbTLHRKl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 12:10:41 -0500
Subject: Re: [PATCH] until blockdev --setrw /dev/scd$n works
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, patmans@us.ibm.com
In-Reply-To: <1070674338.2939.31.camel@patibmrh9>
References: <1070673881.2939.20.camel@patibmrh9>
	 <1070674338.2939.31.camel@patibmrh9>
Content-Type: text/plain
Organization: 
Message-Id: <1070903431.2263.16.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Dec 2003 10:10:31 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2003 17:10:40.0056 (UTC) FILETIME=[3493B380:01C3BDAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +		printk("lk 2.5 ide-cd.c would refuse write\n"); ...
> > +			printk("lk 2.5 sr.c would refuse write\n"); ...
> > +			printk("lk 2.5 cdrom.c would refuse write\n"); ...
> ...
> 2) I have two pre-production samples of the same device: one ATAPI, one
> USB.  Without my patch my ATAPI device never writes, and for my USB
> device I have to volunteer `blockdev --setrw` or `blockdev --setro`
> again after each disc insertion.

Ouch this English doesn't say what I mean.  Instead I should have said:

a) cdrom.ko refuses to pass thru writes unless patched.

b) sr_mod.ko refuses to pass thru writes unless patched.

c) ide-cd.ko refuses to pass thru writes unless patched or asked via
ioctl e.g. via blockdev --setrw.

I'm guessing the maintainers of cdrom.ko sr_mod.ko would accept a patch
to make blockdev --setrw work for those as well as it already does for
ide-cd.ko.

Pat LaVarre


