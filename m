Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbUDGCaY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 22:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbUDGCaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 22:30:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2493 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264083AbUDGCaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 22:30:21 -0400
Date: Wed, 7 Apr 2004 03:30:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Sergiy Lozovsky <serge_lozovsky@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge
Message-ID: <20040407023020.GO31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406174412.7850.qmail@web40511.mail.yahoo.com> <200404070102.i3712nDe002647@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404070102.i3712nDe002647@eeyore.valparaiso.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:02:49PM -0400, Horst von Brand wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > If stack will shrink - i'll come up with something.
> 
> Good luck! When it is done shrinking, there won't be much (if any) left for
> you to play with.
> 
> > Rearchitecture of LISP interpreter - is too much work.
> 
> Implement a kernel-side LISP interpreter isn't...

It's a userland (and leaky, at that) LISP interpreter plus some glue and duct
tape to make it kinda-sorta work in kernel mode - enough for a demo, in any
case.  BTW, the LISP dialect implemented by that interpreter is unimpressive,
to put it mildly.  Even aside of atrocious "GC" and lexer (BTW, have the
author of RefLISP ever heard of arcane technics known as "checking the return
value of malloc"?), semantics of his EVAL would be a shame even in 70s (at
any point after Landin's papers, actually).  Sigh...
