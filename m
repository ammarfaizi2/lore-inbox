Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVDTSRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVDTSRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVDTSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:17:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40123 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261779AbVDTSR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:17:28 -0400
Subject: Re: nVidia stuff again
From: Doug Ledford <dledford@redhat.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <425E77BB.5010902@aitel.hist.no>
References: <1113298455.16274.72.camel@caveman.xisl.com>
	 <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com>
	 <20050412210857.GT11199@shell0.pdx.osdl.net>
	 <1113341579.3105.63.camel@caveman.xisl.com>
	 <425CEAC2.1050306@aitel.hist.no>
	 <20050413125921.GN17865@csclub.uwaterloo.ca>
	 <20050413130646.GF32354@marowsky-bree.de>
	 <20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com>
	 <425E77BB.5010902@aitel.hist.no>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 14:17:04 -0400
Message-Id: <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 16:01 +0200, Helge Hafting wrote:
>  instead of keeping them secret for no
> good reason.

But *that's* the point people keep ignoring: the specs for programming
the hardware, in some cases, reveals details about the hardware's
implementation that nVidia does *not* want to release (in addition to
suggesting their software tricks).  Why is it that people *assume* that
just the programming docs tells a person nothing about the hardware?  We
already know that knowing the registers of a card and what those
registers do tells you implicit information about the card's design and
also reveals implicit information about the design of software that
works with the card.  How complex the card's registers and programming
interface is determines how much you can infer, and the more RISC like
or simple the card is and the more that is handled in the driver, the
more obviously the design can be inferred just from the programming
specs.

The aic7xxx chips are a perfect example of this exact same thing.  If
you know how to program the registers on that card, then you know almost
everything about the hardware.  It's that simple (and that's a big part
of what makes it very fast, lots of room for driver optimizations and
enhanced feature support).

-- 
Doug Ledford <dledford@redhat.com>
http://people.redhat.com/dledford


