Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269619AbUICJYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269619AbUICJYc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269476AbUICJYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:24:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8200 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269577AbUICJUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:20:33 -0400
Date: Fri, 3 Sep 2004 10:20:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-ID: <20040903102027.B7535@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040903014811.6247d47d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040903014811.6247d47d.akpm@osdl.org>; from akpm@osdl.org on Fri, Sep 03, 2004 at 01:48:11AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> - Status update on various large patches in -mm:

As far as the serial patches go, there's a bug in bugzilla where
a problem has been reported in -mm, whereas non-mm works fine...

I also have some pending serial changes for Linus, but haven't
received any "it works" "it doesn't work" reports back so I'm not
happy to push this during the -rc phase.

PCMCIA wise, I want to dump a couple of Dominik's earlier patches
in which start moving code around to separate the core PCMCIA/Cardbus
code from the PCMCIA specific "card services" code.  See

  http://pcmcia.arm.linux.org.uk/

for details on this.  I want patch series 14 to be merged into Linus'
tree separately from 15 and 16 so that if someone finds a problem
down the line, it's easy to isolate it between the changes.  Note that
I _still_ haven't heard back from the guy who reported a deadlock with
current kernels, so I'm unsure about merging the validatemem patch.
I really want to do this before series 15 and 16.  I'll probably decide
to take the approach of just applying the proposed fix without having
it tested in the reported scenario and hope for the best...

Once patch series 14, 15 and 16 are in, driver model stuff seems to
be the next thing on the cards for PCMCIA.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
