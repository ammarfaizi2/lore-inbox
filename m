Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbTKKSgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263742AbTKKSgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:36:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:18060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263733AbTKKSgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:36:49 -0500
Date: Tue, 11 Nov 2003 10:36:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Erik Jacobson <erikj@subway.americas.sgi.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
In-Reply-To: <12800000.1068577034@flay>
Message-ID: <Pine.LNX.4.44.0311111033340.30657-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Martin J. Bligh wrote:
> 
> OK, I was actually trying to avoid the use of vmalloc, instead of the 
> unconditional conversion to vmalloc, which is what the original patch did ;-)

Yes, I realize that, but it's the old case of

  "I'm totally faithful to my husband - I never sleep with other men when 
   he is around"

joke.

Basically, if it's wrong to use, it's wrong to use even occasionally. In 
fact, having two different code-paths just makes the code worse.

Yes, I realize that sometimes you have to do it that way, and it might be 
the simplest way to fix something. In this case, though, the cost and 
fragility of a generic interface is not worth it, since the problem isn't 
actually in the generic code at all..

		Linus

