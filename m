Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269596AbUJFX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269596AbUJFX1v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269574AbUJFX0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:26:08 -0400
Received: from hera.kernel.org ([63.209.29.2]:38295 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S269596AbUJFXUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:20:32 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Probable module bug in linux-2.6.5-1.358
Date: Wed, 06 Oct 2004 16:20:33 -0700
Organization: Open Source Development Lab
Message-ID: <1097104833.26149.3.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0410061807030.4586@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1097104824 23122 172.20.1.60 (6 Oct 2004 23:20:24 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 6 Oct 2004 23:20:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 18:08 -0400, Richard B. Johnson wrote:
> The attached script shows that an attempt to open a device
> after its module was removed, will seg-fault the kernel.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
>              Note 96.31% of all statistics are fiction.



Oct  6 17:03:30 chaos kernel: Analogic Corp Datalink Driver : Module
removed

The bug is in that driver. It needs to unregister the character device
in it's module remove routine.  It doesn't appear to be in the main
kernel source tree so bug Redhat or the vendor.

