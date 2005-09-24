Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVIXSYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVIXSYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 14:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVIXSYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 14:24:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932222AbVIXSYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 14:24:24 -0400
Date: Sat, 24 Sep 2005 11:23:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mattia Dongili <malattia@linux.it>
Cc: linux-kernel@vger.kernel.org, "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: 2.6.14-rc2-mm1
Message-Id: <20050924112339.342b82e1.akpm@osdl.org>
In-Reply-To: <20050924175848.GD3586@inferi.kami.home>
References: <20050921222839.76c53ba1.akpm@osdl.org>
	<20050924175848.GD3586@inferi.kami.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattia Dongili <malattia@linux.it> wrote:
>
>  On Wed, Sep 21, 2005 at 10:28:39PM -0700, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.6.14-rc2-mm1/
> 
>  Herm... running almost good :) I just got the below allocation failure
>  (including /proc/slabinfo and /proc/vmstat, useful? can provide more
>  info if happens again - ah, exim is just running for the local delivery
>  purpose only). I did see it previously in .14-rc1-mm1 only but I didn't
>  find time enough to report it properly.
> 
> ...
>  exim4: page allocation failure. order:1, mode:0x80000020

Yes, it's expected that
mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch will cause more
fragmentation and will hence cause higher-order allocation attempts to
fail.

I think I'll drop that one.
