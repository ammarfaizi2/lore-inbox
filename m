Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFXQ0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFXQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:26:08 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:54500 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261939AbTFXQ0F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:26:05 -0400
Date: Tue, 24 Jun 2003 10:41:23 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: aic7xxx driver update
Message-ID: <866810000.1056472883@aslan.btc.adaptec.com>
In-Reply-To: <Pine.LNX.4.55L.0306240159480.31432@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0306240159480.31432@freak.distro.conectiva>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Justin,
> 
> Would you mind sending me a inlined patch to update aic7xxx to the current
> sources, with detailed explanation?

Can you be more specific about what you need?  I take it the BK send output
on my website is not sufficient?  I can probably figure out the proper
BK magic to generate a patch for it, but I would hope that you would,
after review, just accept the BK data so that revision history is not
lost.

The BK data has lots of changelog information since there are 108 changesets
in my local BK tree that are not in your tree.  I can provide more details
about any particular changeset that peaks your interest.

> Are there any known issues with the new code, and what are them.

For both drivers, I'm currently working on an error recovery handler that
will override the standard one.  The standard handler is broken in
so many ways that it would be hard to list them briefly.  The short
of it is that if you get a timeout, it may take 20 minutes for you
to recover and recovery is rare.  Timeouts occur in almost any system
should you run it long enough, so this is unacceptable.  Unfortunately,
having the mid-layer do all of the recovery will likely never work.
The mid-layer can't determine the most likely transaction outstanding
that is causing the timeout whereas the end driver can.  I hope to have
the new error handler tested sufficiently for release by the end of this
week.

For the aic79xx driver, we are going through qualification of new drives
and new drive firmware.  There are a few issues that we are investigating
now that should also be resolved this week.

My suggestion would be to shoot for say next Monday as a good time to
sync up.  I can provide whatever material you require for released
changesets today so that you can review all but the latest changes
before Monday.

--
Justin

