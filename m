Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWEOTjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWEOTjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWEOTjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:39:33 -0400
Received: from ns1.suse.de ([195.135.220.2]:18640 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964878AbWEOTjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:39:31 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 21:38:56 +0200
User-Agent: KMail/1.9.1
Cc: Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       apw@shadowen.org, linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <200605152111.20693.ak@suse.de> <20060515192614.GA24887@elte.hu>
In-Reply-To: <20060515192614.GA24887@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152138.57347.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
> and debugged on 32-bit too, because x86_64 debugging is still quite a 
> PITA and wastes alot of time: for example it has no support for exact 
> kernel stacktraces.

Hopefully soon.

I think i386 only gained it very recently, so it can't be _that_ big
a problem.

The real issue is too deeply nested code like the callback hell
we have in some subsystems. Better would be to eliminate that. 2.4
was much nicer in this regard and there has been quite a lot of 
unnecessary complications in this area when the kernel went to 2.6.

> Also, the printout of the backtrace is butt-ugly and  
> as un-ergonomic to the human eye as it gets - who came up with that 
> "two-maybe-one function entries per-line" nonsense? [Whoever did it he 
> never had to look at (and make sense of) hundreds of stacktraces in a 
> row.]

The original goal was to make it fit as much as possible on 
the screen when you don't have a serial/net/fireconsole.
But arguably it's less and less useful because the kernel
has gotten so huge that most backtraces are very long and scroll
away anyways.

-Andi
