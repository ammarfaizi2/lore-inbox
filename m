Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUCSJRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbUCSJRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:17:31 -0500
Received: from mail.shareable.org ([81.29.64.88]:34702 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261995AbUCSJR3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:17:29 -0500
Date: Fri, 19 Mar 2004 09:17:22 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Driver Core update for 2.6.4
Message-ID: <20040319091722.GD2650@mail.shareable.org>
References: <1AajM-5vw-21@gated-at.bofh.it> <1Abpq-6Av-1@gated-at.bofh.it> <1Aj3K-5Fn-9@gated-at.bofh.it> <1AjwZ-65D-15@gated-at.bofh.it> <m3brmwojk8.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3brmwojk8.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > eh?  If there is any argument against this code it is that it is so simple
> > that the thing which it abstracts is not worth abstracting.  But given that
> > it is so unwasteful, this seems unimportant.
> 
> The bloat argument was about the additional pointer in the dynamic 
> data structure (on a 64bit architecture it costs 12 bytes) 

This is one place where C++-style vtable inheritance would help.
Many of those *_operations tables could logically derive from a kref_operations table.

I doubt if there is a nice to way to represent it with C macros, but
maybe there is.

-- Jamie
