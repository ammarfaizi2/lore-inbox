Return-Path: <linux-kernel-owner+w=401wt.eu-S1762363AbWLJWtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762363AbWLJWtP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 17:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762358AbWLJWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 17:49:15 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:41156 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761978AbWLJWtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 17:49:13 -0500
X-YMail-OSG: .6FzddIVM1l929pW9Ny64bDH_9mWj0cSrotRlPFQjYUSqtESLhjY860Epoc5rw2ZQaeiu5ELuMCHwP1VmgGQr7QQsGc3QYuY7jlgWjncov0vWVeb8xavHZC5mSMKQcaNUYpdHVWrFguNwQY-
Date: Sun, 10 Dec 2006 14:49:03 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Drake <dsd@gentoo.org>, Adrian Bunk <bunk@stusta.de>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061210224903.GA23643@tuatara.stupidest.org>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de> <457C345D.8030305@gentoo.org> <20061210223351.GA22878@tuatara.stupidest.org> <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 02:39:37PM -0800, Linus Torvalds wrote:

> They should be safe, and OBVIOUS.

Well, it's not clear to me that reverting to a quirk the pokes *all*
VIA pci devices on all machines is safe, it's not even clear if it was
a good idea to merge this.

All the same, I can retest the latest 2.6.16.x with that change
reverted but since it originally caused pain there has been a BIOS
upgrade (or two, I forget) that might affect things (for many poeple
the quirk isn't needed and CPI does the right thing).

> If there is a box that breaks with a 2.6.x.y release, then that .y
> release was clearly a mistake, and fundamentally broke the whole
> point of the 3Astable tree.

Well, I think the current 2.6.16.x release series is already broken on
some other subset of hardware.

There might be more of those than there are with the quirk-me-hard
approach --- in which case do we try to accommodate the (potential)
majority with something that is clearly wrong or so we leave them
broken for a bit longer until we can get some more coverage on Alan's
much cleaner and specific fix which I think is slated for 2.6.20 and
then backport that?
