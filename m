Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUJOAKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUJOAKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267661AbUJOAKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:10:40 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:54208 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267334AbUJOAIm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:08:42 -0400
Date: Fri, 15 Oct 2004 09:08:41 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Robin Holt <holt@sgi.com>
Subject: Re: Yet another crash dump tool
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
In-Reply-To: <20041014112938.GE19122@lnx-holt.americas.sgi.com>
References: <20041014074718.26E6.ODA@valinux.co.jp> <20041014112938.GE19122@lnx-holt.americas.sgi.com>
Message-Id: <20041015081246.26EB.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> dump device.  Can you dump device span multiple volumes?  If I
yes. (maybe. suppose logical volume.)

> have a system using 1TB of physical memory, but 98% of that
> is allocated as huge TLB pages for users, do I _REALLY_ need to
> dump them all?
yes, absolutely, for us.

Our target is customer's production system, not developping/debugging
system. The chance of capturing fault analysis materials may be only
one time. If a kernel destroy the memory using user process(page cache
, buffer cache), looking the pattern of destroy is great helpful to 
analyze. (note that I have encountered such case many times)
We also analyze user proccesses at the crash time from the dump.

> lkcd, and I would hope others, only dump kernel pages unless
> configured to do otherwise.

You should chose a dump tool you like.

We believe we need whole memory. But we understand there is an opinion
like you (reduce saving memory is better). We don't force to use our
tool. We make "mini kernel dump" as independent from kernel as possible.

Thank you.
-- 
Itsuro ODA <oda@valinux.co.jp>

