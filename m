Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUAWJLX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265625AbUAWJLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:11:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:47047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265327AbUAWJLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:11:13 -0500
Date: Fri, 23 Jan 2004 01:11:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: glennpj@charter.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm1 oops with X
Message-Id: <20040123011158.665ad574.akpm@osdl.org>
In-Reply-To: <1074848612.23073.81.camel@imladris.demon.co.uk>
References: <20040123061927.GA7025@gforce.johnson.home>
	<20040122231814.149c8e8d.akpm@osdl.org>
	<1074848612.23073.81.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2004-01-22 at 23:18 -0800, Andrew Morton wrote:
> > It is maddeningly hard to debug even when you can reproduce it, which I can
> > no longer do.
> 
> This is what GDB watchpoints were invented for, surely?
> 

I suppose that might help.  But for me the bug triggered towards the end of
initscripts (it moves around) after we've been through that code path a
zillion times.  It probably needs to be solved by inspection.  If one can
get it to happen reliably.

I found that sysfs-class-10-vc.patch caused it to happen and
use-kthread-primitives.patch made it go away again.  Neither patch has
anything to do with tty refcounting and locking.

