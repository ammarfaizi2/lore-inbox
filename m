Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRFOCHZ>; Thu, 14 Jun 2001 22:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbRFOCHP>; Thu, 14 Jun 2001 22:07:15 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:44306 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261473AbRFOCG7>;
	Thu, 14 Jun 2001 22:06:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106150206.f5F26kB455810@saturn.cs.uml.edu>
Subject: Re: VGA handling was [Re: Going beyond 256 PCI buses]
To: davem@redhat.com (David S. Miller)
Date: Thu, 14 Jun 2001 22:06:46 -0400 (EDT)
Cc: jsimmons@transvirtual.com (James Simmons),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        linux-kernel@vger.kernel.org
In-Reply-To: <15145.19442.773217.177804@pizda.ninka.net> from "David S. Miller" at Jun 14, 2001 04:42:42 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> You going to have to enable/disable I/O, MEM access, and VGA pallette
> snooping in the PCI_COMMAND register of both boards every time you go
> from rendering text on one to rendering text on the other.  If there
> are bridges leading to either device, you may need to fiddle with VGA
> forwarding during each switch as well.
> 
> You'll also need a semaphore or similar to control this "active VGA"
> state.
> 
> Really, I don't think this is all that good of an idea.

It might not be so bad if you assume that one doesn't blast away
with interleaved operations between the displays. Lazy switching
means you can do a whole user-interface action without needing
to muck with bridges. By "user-interface action" I mean something
like a "make menuconfig" screen refresh.

