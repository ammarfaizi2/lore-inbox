Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTLVWXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTLVWXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:23:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:63131 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264537AbTLVWXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:23:34 -0500
Date: Mon, 22 Dec 2003 14:24:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: rml@ximian.com, wli@holomorphy.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: atomic copy_from_user?
Message-Id: <20031222142426.24c8951e.akpm@osdl.org>
In-Reply-To: <20031222215933.GA3189@rudolph.ccur.com>
References: <1072054100.1742.156.camel@cube>
	<20031222150026.GD27687@holomorphy.com>
	<20031222182637.GA2659@rudolph.ccur.com>
	<1072126506.3318.31.camel@fur>
	<20031222212237.GA2865@rudolph.ccur.com>
	<1072129210.3318.34.camel@fur>
	<20031222215933.GA3189@rudolph.ccur.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
> > inc_preempt_count() and dec_preempt_count() are for use when you
> > _absolutely_ must manage the preemption counter, regardless of whether
> > or not kernel preemption is enabled.
> > 
> > They are used for things like atomic kmaps.
> 
> Hi Robert,
>  I do not see why a non-preempt kernel would care at all about
> the value of preempt_count.  (kmap_atomic is obviously setting it,
> where is the place in a non-preempt kernel where the set value
> is being acted upon?).

do_page_fault()'s in_atomic() test.
