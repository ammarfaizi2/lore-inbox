Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbTLMAZf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTLMAZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:25:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49122 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262356AbTLMAZb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:25:31 -0500
Date: Sat, 13 Dec 2003 00:25:30 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nix <nix@esperi.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031213002530.GL4176@parcelfarce.linux.theplanet.co.uk>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <Pine.LNX.4.58.0312031533530.2055@home.osdl.org> <Pine.LNX.4.58.0312031614000.2055@home.osdl.org> <20031204192452.GC10421@parcelfarce.linux.theplanet.co.uk> <877k11y3sh.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877k11y3sh.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 12:11:58AM +0000, Nix wrote:
> > 	Some approximation might be obtained by building all modules and
> > doing nm on them, with manual work for non-obvious cases.
> 
> Hang on, surely you can tell which symbols in modules are exported just
> by looking for expansions of EXPORT_SYMBOL{_GPL}? Why is this bit hard?

It's not a question of which symbols are exported by module, it's what
symbols are _imported_.

IOW, the hard question is "what modules use foo()", not "where do we define
foo()".  And while it's easy for a single symbol, we want it for _all_
exported symbols in the tree at once.
