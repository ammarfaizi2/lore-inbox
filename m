Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTERWVy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTERWVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:21:54 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:642 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S262228AbTERWVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:21:53 -0400
Date: Sun, 18 May 2003 23:34:46 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, Dave Jones <davej@codemonkey.org.uk>,
       kraxel@suse.de, jsimmons@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030518223446.GA8591@mail.jlokier.co.uk>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de> <1053118296.5599.27.camel@dhcp22.swansea.linux.org.uk> <20030518053935.GA4112@averell> <20030518161105.GA7404@mail.jlokier.co.uk> <1053290431.27107.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053290431.27107.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > What exactly "doesn't work" with these cards?
> 
> If you sent an MTRR you get crap on the display. I'm not sure if that is
> registers being covered (seems dubious) or other PCI problems perhaps
> with bursts

Is it consistently bad, or is it just an occasional glitch, pixel here
or there that goes wrong?

I like your suggestion of PCI bursts - perhaps the card's FIFO to
video RAM overflows due to RAM being too slow or too busy for display
reads.  It seems quite plausible.  It might even depend on the video mode.

If that's the problem, a test which writes a data pattern to a
significant chunk of video RAM in sequence, as fast as possible, and
then reads it would be practically guaranteed to spot this and
indicate that MTRRs aren't suitable for this card in this mode.

-- Jamie

