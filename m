Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268530AbUILIZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268530AbUILIZm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 04:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268532AbUILIZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 04:25:42 -0400
Received: from colin2.muc.de ([193.149.48.15]:60932 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S268530AbUILIZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 04:25:40 -0400
Date: 12 Sep 2004 10:25:39 +0200
Date: Sun, 12 Sep 2004 10:25:38 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, hugh@veritas.com, wli@holomorphy.com,
       takata.hirokazu@renesas.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic_inc_return() for i386[1/5] (Re: atomic_inc_return)
Message-ID: <20040912082538.GA87823@muc.de>
References: <Pine.LNX.4.44.0409092005430.14004-100000@localhost.localdomain> <200409100326.i8A3QsYV007096@mailsv.bs1.fc.nec.co.jp> <20040911160532.07216174.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911160532.07216174.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 04:05:32PM -0700, Andrew Morton wrote:
> kaigai@ak.jp.nec.com (Kaigai Kohei) wrote:
> >
> > 
> > [1/5] atomic_inc_return-linux-2.6.9-rc1.i386.patch
> >   This patch implements atomic_inc_return() and so on for i386,
> >   and includes runtime check whether CPU is legacy 386.
> >   It is same as I posted to LKML and Andi Kleen at '04/09/01.
> > 
> 
> Can we not use the `alternative instruction' stuff to eliminate the runtime
> test?

Yes, we could. I suggested this to Kaigai-san earlier, but
he decided that it was too complicated because he would have needed
to add an additional alternative() macro with enough parameters.

Given that atomic instructions are quite costly anyways and the jump
should be very predictable he's probably right that it wouldn't 
be worth the effort. 

-Andi
