Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTKJN31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263572AbTKJN31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:29:27 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:17812
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263564AbTKJN30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:29:26 -0500
Date: Mon, 10 Nov 2003 14:26:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Larry McVoy <lm@bitmover.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110132617.GA6834@x30.random>
References: <20031109152534.GA24312@work.bitmover.com> <Pine.LNX.4.44.0311090737550.12198-100000@bigblue.dev.mdolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311090737550.12198-100000@bigblue.dev.mdolabs.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 07:42:09AM -0800, Davide Libenzi wrote:
> On Sun, 9 Nov 2003, Larry McVoy wrote:
> 
> > On Sun, Nov 09, 2003 at 07:16:15AM -0800, H. Peter Anvin wrote:
> > > That doesn't include anyone who uses the mirrored repository on the
> > > main kernel.org machines.  
> > 
> > Last I checked, kernel.org isn't offering pserver access, just ftp.  If you
> > want to take over the CVS access just say the word.
> 
> It is faster for me to use rsync on the CVS root locally, and then use the 
> local repository instead. Rsync is better than CVS when it comes to syncs.
> Cvsps expecially, really wants a local repository when you start playing 
> heavily with -g.

same here, however the rsync export on kernel.org is lacking a two
sequence number locking that would allow us to checkout a coherent copy
of the cvs repository.  Currently it works by luck.

if we add the two sequence numbers to the rsync on kernel.org, I believe
shutting down the pserver is ok.
