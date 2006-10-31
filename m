Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751987AbWJaFjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbWJaFjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 00:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWJaFjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 00:39:22 -0500
Received: from colo.lackof.org ([198.49.126.79]:51844 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751987AbWJaFjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 00:39:21 -0500
Date: Mon, 30 Oct 2006 22:39:19 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Linus Torvalds <torvalds@osdl.org>,
       "Adam J. Richter" <adam@yggdrasil.com>, akpm@osdl.org, bunk@stusta.de,
       greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, pavel@ucw.cz, shemminger@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061031053919.GA4726@colo.lackof.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com> <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org> <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com> <20061030144259.GD10235@parisc-linux.org> <87F87E8E-9434-4844-AA3F-ED850BEFAD29@mac.com> <20061030191307.GE10235@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030191307.GE10235@parisc-linux.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 12:13:07PM -0700, Matthew Wilcox wrote:
> Probing PCI devices really doesn't take that long.

Yeah - usually measured in "milliseconds".

> It's the extra stuff
> the drivers do at ->probe that takes the time.  And the stand-out
> offender here is SCSI (and FC), which I'm working to fix.  Firewire, USB
> and SATA are somewhere intermediate.

ISTR that the SATA Port timeout is 5 seconds or something like that.
And some cards have lots of ports...so my impression is SATA would
benefit alot from parallelism as well.

I'm certainly no SATA expert...maybe someone else could speak
more definitely on the topic of worst case SATA timeout.

thanks,
grant
