Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263443AbTC2RjZ>; Sat, 29 Mar 2003 12:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263444AbTC2RjZ>; Sat, 29 Mar 2003 12:39:25 -0500
Received: from ns.suse.de ([213.95.15.193]:11783 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263443AbTC2RjY>;
	Sat, 29 Mar 2003 12:39:24 -0500
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC renaming does not rename /proc/sys/net/ipv4 Was: Re: NICs trading places ?
References: <20030328221037.GB25846@suse.de.suse.lists.linux.kernel.suse.lists.linux.kernel>
	<p73isu2zsmi.fsf@oldwotan.suse.de.suse.lists.linux.kernel>
	<20030329121755.GA17169@outpost.ds9a.nl.suse.lists.linux.kernel>
	<1048940960.2176.86.camel@averell.suse.lists.linux.kernel>
	<20030329142519.GG2078@wiggy.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Mar 2003 18:50:41 +0100
In-Reply-To: <20030329142519.GG2078@wiggy.net.suse.lists.linux.kernel>
Message-ID: <p73adfeyscu.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman <wichert@wiggy.net> writes:

> > Just rename at early boot before IP is set up.  That is what i usually
> > do - set up /etc/mactab and run it very early at boot.
> 
> How does that solve the problem of /proc/sys/net/*/conf/* not being
> renamed?

They are only set up when the inet device structure is created.
That happens at the first ifconfig/ip, not on driver init.

As for non ethernet devices - if you find a reliably way to identify/number
them then the same principle can be used for them too.

-Andi
