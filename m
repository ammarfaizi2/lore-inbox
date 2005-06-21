Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262270AbVFUTzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbVFUTzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVFUTzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:55:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262270AbVFUTzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:55:18 -0400
Date: Tue, 21 Jun 2005 12:54:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Hicks <mort@wildopensource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-Id: <20050621125457.2e4355c6.akpm@osdl.org>
In-Reply-To: <20050621140831.GQ29510@localhost>
References: <20050620235458.5b437274.akpm@osdl.org>
	<20050621140831.GQ29510@localhost>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks <mort@wildopensource.com> wrote:
>
> On Mon, Jun 20, 2005 at 11:54:58PM -0700, Andrew Morton wrote:
>  > 
>  > vm-early-zone-reclaim
>  > 
>  >     Needs some convincing benchmark numbers to back it up.  Otherwise OK.
> 
>  The only benchmarks I have for this were included in my last mail to
>  linux-mm:
> 
>  http://marc.theaimsgroup.com/?l=linux-mm&m=111763597218177&w=2
> 
>  Are they convincing?  Well, the patch doesn't seem to make the memory
>  thrashing case much worse ("make -j" kernbench run) which is a good
>  thing since the VM is trying to reclaim much earlier.
> 
>  In the same e-mail I mention that there is a fairly good performance
>  gain in the optimal case, where processes are tied to a single node and
>  the node's memory is filled with page cache.  With zone reclaim turned
>  on the "make -j8" kernel build runs in 700 seconds;  735 seconds with
>  no reclaim.

Ah, OK, I failed to capture that info.  (I always have to move the info in
the [patch 0/n] email into the first real patch, and this time I didn't)

Thanks.
