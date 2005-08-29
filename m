Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVH2EDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVH2EDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 00:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVH2EDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 00:03:11 -0400
Received: from mailhub.hp.com ([192.151.27.10]:49577 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S1750725AbVH2EDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 00:03:11 -0400
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
From: Alex Williamson <alex.williamson@hp.com>
To: Andreas Schwab <schwab@suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <jehdda2tqt.fsf@sykes.suse.de>
References: <jehdda2tqt.fsf@sykes.suse.de>
Content-Type: text/plain
Organization: OSLO R&D
Date: Sun, 28 Aug 2005 22:02:55 -0600
Message-Id: <1125288175.5595.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-28 at 13:20 +0200, Andreas Schwab wrote:
> The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
> at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
> It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
> probably a dormant bug that was just uncovered by the change.

   Same thing on Mac Mini.  2.6.13 doesn't boot.  Revert the
drivers/pci/setup-res.c change from rc7-git2 and it seems ok.

	Alex

