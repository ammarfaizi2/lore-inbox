Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266066AbUAFEEQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 23:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbUAFEEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 23:04:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29584 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266066AbUAFEEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 23:04:12 -0500
Date: Mon, 5 Jan 2004 19:58:27 -0800
From: "David S. Miller" <davem@redhat.com>
To: Martin Diehl <lists@mdiehl.de>
Cc: irda-users@lists.sourceforge.net, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [irda-users] (irda) Badness in local_bh_enable at
 kernel/softirq.c:121
Message-Id: <20040105195827.0b15403f.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0312270027560.30804-100000@notebook.home.mdiehl.de>
References: <Pine.LNX.4.44.0312270006190.30804-100000@notebook.home.mdiehl.de>
	<Pine.LNX.4.44.0312270027560.30804-100000@notebook.home.mdiehl.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 00:33:34 +0100 (CET)
Martin Diehl <lists@mdiehl.de> wrote:

> On Sat, 27 Dec 2003, Martin Diehl wrote:
> 
> > Beware, there's another local_bh_enable issue with ircomm even with this 
> > patch applied. It's triggered when the ircomm-dev wasn't closed by the 
> > application before exiting (say kill -9 f.e.). So if you get another such 
> > badness warning with slightly different backtrace, chances are you also 
> > want to apply the "IrCOMM detach Oops" fixes from Jean's page.
> 
> Oops, right after sending this I realized you aren't using the sirdev at 
> all, so in fact this is already the second case triggered from the 
> ircomm-shutdown path - like davem was already pointing to.
> Below said patch from Jean.

I'm going to add this to my tree, the patch looks perfectly fine
and we might as well get this thing fixed now rather than later.
