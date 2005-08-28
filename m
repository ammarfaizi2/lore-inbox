Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVH1LUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVH1LUd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 07:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVH1LUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 07:20:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38048 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751141AbVH1LUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 07:20:32 -0400
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.13-rc7-git2 crashes on iBook
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
X-Yow: Did I do an INCORRECT THING??
Date: Sun, 28 Aug 2005 13:20:10 +0200
Message-ID: <jehdda2tqt.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last change to drivers/pci/setup-res.c (Ignore disabled ROM resources
at setup) is breaking radeonfb on iBook G3 (with Radeon Mobility M6 LY).
It crashes in pci_map_rom when called from radeonfb_map_ROM.  This is
probably a dormant bug that was just uncovered by the change.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
