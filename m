Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUAYVNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUAYVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:13:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:9630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264903AbUAYVNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:13:20 -0500
Date: Sun, 25 Jan 2004 13:11:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@muc.de>
Cc: bunk@fs.tum.de, cova@ferrara.linux.it, eric@cisu.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Kernels > 2.6.1-mm3 do not boot. - SOLVED
Message-Id: <20040125131153.16bb662b.akpm@osdl.org>
In-Reply-To: <20040125174837.GB16962@colin2.muc.de>
References: <200401232253.08552.eric@cisu.net>
	<200401251639.56799.cova@ferrara.linux.it>
	<20040125162122.GJ513@fs.tum.de>
	<200401251811.27890.cova@ferrara.linux.it>
	<20040125173048.GL513@fs.tum.de>
	<20040125174837.GB16962@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:
>
> > It seems use-funit-at-a-time breaks with distributions shipping a gcc
> > 3.3 that supports -funit-at-a-time.
> 
> It works for me with the hammer branch gcc 3.3 with -funit-at-a-time.
> 
> Are you sure the exception table sorting patch was properly applied?

I'd say so.  There are no extable patches in current -mm.

> > Th patch below replaces use-funit-at-a-time.patch and uses 
> > scripts/gcc-version.sh from add-config-for-mregparm-3-ng* to use 
> > -funit-at-a-time only with gcc >= 3.4 .
> 
> I disagree with that change.

Well there doesn't seem much doubt that -funit-at-a-time causes Fabio's
kernel to fail.  Do we know exactly which compiler he is using?

