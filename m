Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUBSRRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 12:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUBSRRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 12:17:37 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:8577 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S267394AbUBSRRe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 12:17:34 -0500
From: "Nick Warne" <nick@ukfsn.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Feb 2004 17:17:32 -0000
MIME-Version: 1.0
Subject: Re: 2.6.3 RT8139too NIC problems
Message-ID: <4034EFAC.21065.4E1A8B4@localhost>
In-reply-to: <20040219171122.GA17199@linux-sh.org>
References: <4034E88C.24740.4C5D4B6@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Thu, Feb 19, 2004 at 04:47:08PM -0000, Nick Warne wrote:
> > >From my config file:
> > 
> > # CONFIG_8139CP is not set
> > CONFIG_8139TOO=y
> > # CONFIG_8139TOO_PIO is not set
> > # CONFIG_8139TOO_TUNE_TWISTER is not set
> > # CONFIG_8139TOO_8129 is not set
> > # CONFIG_8139_OLD_RX_RESET is not set
> > # CONFIG_8139_RXBUF_IDX= is not set
> > 
> > No other NIC drivers are used.
> > 
> > I am also stuck as to what the new RXBUF_IDX is for.  It appears the 
> > new build needs it, as I cannot remove.
> > 
> So read the help entry in Kconfig. Before this change went in, pretty much
> everyone defaulted to a 32k receive ring size, which is also the current
> default. If you had used the default value of 2 instead of trying to hack
> around it, you might get better behavior from your driver..

Hi Paul,

My bad...

I did use the default 2... unfortunately that snippet I copied here 
was what I tried to do to rebuild kernel with out it, but make just 
adds the line back in CONFIG and asks what option I what.

So it is set to 2 as per the default.

So, corrected (and as the kernel was built):

# CONFIG_8139CP is not set
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_8139_RXBUF_IDX=2

Nick

-- 
"I am not Spock", said Leonard Nimoy.
"And it is highly illogical of humans to assume so."

