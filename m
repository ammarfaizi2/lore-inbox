Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRGKETI>; Wed, 11 Jul 2001 00:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267197AbRGKES6>; Wed, 11 Jul 2001 00:18:58 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:1801 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267196AbRGKESm>;
	Wed, 11 Jul 2001 00:18:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107110418.f6B4Ief404551@saturn.cs.uml.edu>
Subject: Re: Hardware testing [was Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))]
To: landley@webofficenow.com
Date: Wed, 11 Jul 2001 00:18:40 -0400 (EDT)
Cc: vherva@mail.niksula.cs.hut.fi (Ville Herva), linux-kernel@vger.kernel.org
In-Reply-To: <01071011282504.00634@localhost.localdomain> from "Rob Landley" at Jul 10, 2001 11:28:25 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley writes:

> The third thing (which started this thread) was memory bus.  The new 3DNow 
> optimizations drove a memory bus into failure, and that IS processor 
> specific...
...
> memtest86 is great becuase it ONLY tests memory.  CPUburn is similarly 
> specific.  A memory bus buster would be a good tool to add to the mix.  (DMA 
> is another common problem, but the more I look into it, the more it seems to 
> be dependent on whatever peripheral you're talking to, which is more 
> complication than I'm looking to bite off...)

DMA could be done in a sane manner. Let drivers register a function
to excercise DMA. When you want to test, tell all registered drivers
to start wild excessive DMA. Use a timer to stop this, because you
might end up pretty well locked out of your system while the bus is
busy moving test data.
