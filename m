Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTIEOyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 10:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTIEOyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 10:54:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:57546 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262507AbTIEOyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 10:54:53 -0400
Date: Fri, 5 Sep 2003 07:54:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: akpm@osdl.org, <rth@redhat.com>, <linux-kernel@vger.kernel.org>,
       <jh@suse.cz>
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
In-Reply-To: <20030905004710.GA31000@averell>
Message-ID: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Sep 2003, Andi Kleen wrote:
> 
> Unfortunately the kernel doesn't compile with unit-at-a-time currently,
> it cannot tolerate the reordering of functions in relation to inline
> assembly.

What is the problem exactly? Is it the exception table getting unordered?  
We _could_ just sort it at boot-time (or, even better, at build time after
the final link) instead...

		Linus

