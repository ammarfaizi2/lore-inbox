Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbVLUISq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbVLUISq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 03:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVLUISq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 03:18:46 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37840 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932319AbVLUISq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 03:18:46 -0500
Date: Wed, 21 Dec 2005 08:18:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Nix <nix@esperi.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linda Walsh <lkml@tlinx.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
Message-ID: <20051221081843.GL27946@ftp.linux.org.uk>
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <87d5jru67j.fsf@amaterasu.srvr.nix> <20051220155839.GA9185@mars.ravnborg.org> <87irtjslxx.fsf@amaterasu.srvr.nix> <20051220202559.GK27946@ftp.linux.org.uk> <87psnqnb3z.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psnqnb3z.fsf@amaterasu.srvr.nix>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 07:49:20AM +0000, Nix wrote:
> Well, personally I handle patch-application in cp -al'ed trees by doing
> cp -al via a script, and repatching all currently hardlinked trees
> (obviously if they are very divergent some patches will fail and I'll
> have to fix them up by hand).

... then you edit a file to fix a typo, and have a _nice_ day next Friday
when you notice that stuff got out of sync.

> It works for me well enough to keep hardlinked branches going for in
> some cases years without problems.
> 
> (On top of that, I've sometimes considered a switch to patch(1) that
> switches to truncate-and-rewrite rather than unlink-and-replace. Haven't
> implemented it yet though.)
> 
> 
> (And if you're using this to maintain development branches, then you
> have resync and conflict-management problems *anyway*, which this makes
> no worse.)

Yes, but it's easier to deal with when the number of your repositories
doesn't get multiplied by factor of 20 or so...
