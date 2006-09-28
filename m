Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWI1WOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWI1WOQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWI1WOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:14:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932199AbWI1WOP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:14:15 -0400
Date: Thu, 28 Sep 2006 15:14:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: roland <devzero@web.de>, Fengguang Wu <fengguang.wu@gmail.com>,
       linux-kernel@vger.kernel.org, lserinol@gmail.com
Subject: Re: I/O statistics per process
Message-Id: <20060928151409.f0a9bda7.akpm@osdl.org>
In-Reply-To: <451C45F1.1050604@engr.sgi.com>
References: <0e2001c6de7a$fe756280$962e8d52@aldipc>
	<359067036.19509@ustc.edu.cn>
	<008f01c6e27a$f9bd5460$962e8d52@aldipc>
	<20060927155549.4a69490d.akpm@osdl.org>
	<451C1AAA.3090301@engr.sgi.com>
	<20060928120952.9f09cbf7.akpm@osdl.org>
	<451C45F1.1050604@engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 15:00:17 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> >>>    in __set_page_dirty_[no]buffers().) (But that ends up being wrong if
> >>>    someone truncates the file before it got written)
> >>>
> >>> - it doesn't account for file readahead (although it easily could)
> >>>
> >>> - it doesn't account for pagefault-initiated readahead (it could)
> >>>
> 
> Mmm, i am not a true FS I/O person. The data collection patches i
> submitted in Nov 2004 was the code i inherited and has been
> used in production system by our CSA customers. We lost a bit in
> contents and accuracy when CSA was ported from IRIX to Linux. I am
> sure there is room for improvement without much overhead.

OK, well it sounds like we're free to define these in any way we like.  So
we actually get to make them mean something useful - how nice.

I hereby declare: "approxmiately equal to the number of filesystem bytes
which this task has caused to occur, or which shall occur in the near
future".

> Maybe FS
> I/O guys can chip in?

I used to be one of them.  I can take a look at doing this.  Given the lack
of any applciation to read the darn numbers out I guess I'll need to expose
them in /proc for now.  Yes, that monitoring patch (and an application to
read from it!) would be appreciated, thanks.

