Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWBQUxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWBQUxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbWBQUxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:53:31 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751773AbWBQUxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:53:30 -0500
Date: Fri, 17 Feb 2006 12:50:54 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-Id: <20060217125054.1446958e.pj@sgi.com>
In-Reply-To: <20060217115958.GA14938@elte.hu>
References: <20060216094130.GA29716@elte.hu>
	<20060216132309.fd4e4723.pj@sgi.com>
	<20060216215036.GD25738@elte.hu>
	<20060216205618.d4d97d9d.pj@sgi.com>
	<20060217115958.GA14938@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [ ... nice writeup of the robust-futex ABI ... ]
> 
> can i put this into Documentation/robust-futex-ABI.txt?

Good idea - so be it.

Could you review it for accuracy -- I'm sure I screwed
it up in some details, large or small.

Ulrich -- if you're reading this -- your review comments
would be most welcome as well.

In particular:
 1) See the description of the removal protocol, below
    the XXX comment.  I was really guessing there.
 2) Could you add a statement on how current code should
    handle the FUTEX_OWNER_PENDING bit (when to set it,
    when to clear it, when to preserve it) so that current
    code won't be incompatible with likely future uses of
    this big?
 3) You have implicit ABI versioning in the size of the
    head struct.  Could you add words describing that?

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
