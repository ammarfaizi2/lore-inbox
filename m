Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUHaGo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUHaGo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUHaGo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:44:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:18063 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266753AbUHaGot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:44:49 -0400
Date: Mon, 30 Aug 2004 23:39:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: nickpiggin@yahoo.com.au, hugh@veritas.com, dice@mfa.kfki.hu,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Message-Id: <20040830233914.0734fdd6.akpm@osdl.org>
In-Reply-To: <1093933516.2424.55.camel@dyn319181.beaverton.ibm.com>
References: <Pine.LNX.4.44.0408281519300.4593-100000@localhost.localdomain>
	<413131A0.4070100@yahoo.com.au>
	<1093933516.2424.55.camel@dyn319181.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> > OK - maybe that can go for a spin in the next -mm. Andrew did you
> > get it?
> 
> So in case my vote counts, add my vote too :)  .
> 

Can someone send me the patch?

> 
> But the biggest performance boost has been seen with large max-readahead
> window sizes. Currently most of the underlying block devices default to
> 32 pages max-readahead  even though the underlying device can handle
> much larger reads. We could extract much more sequential read
> performance if the max-readahead was set to much higher values like 256
> pages which most modern devices are capable off. The problem AFAICT is
> that the block device layer defaults the max-readahead value for most
> block devices to 32, without consulting the capability of the underlying
> block device driver. 

This can be done in startup scripts.
