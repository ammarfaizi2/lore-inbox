Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUFELk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUFELk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 07:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUFELk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 07:40:57 -0400
Received: from mail2.bluewin.ch ([195.186.4.73]:48374 "EHLO mail2.bluewin.ch")
	by vger.kernel.org with ESMTP id S261162AbUFELk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 07:40:56 -0400
Date: Sat, 5 Jun 2004 13:40:52 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Matrox Kconfig
Message-ID: <20040605114052.GA20401@k3.hellgate.ch>
Mail-Followup-To: Petr Vandrovec <vandrove@vc.cvut.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.7-rc1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The descriptions for CONFIG_FB_MATROX_G450 and CONFIG_FB_MATROX_G100A
in drivers/video/Kconfig (current 2.6) are confusing: Both want to be
selected for Matrox G100, G200, G400 based video cards.

In the menu, it's

# G100/G200/G400/G450/G550 support (sets FB_MATROX_G100, FB_MATROX_G450)
#	G100/G200/G400 support     (sets FB_MATROX_G100)
#	G400 second head support

where the second depends on the first _not_ being selected.

How about this instead?

# Gxxx (generic) (sets FB_MATROX_G100)
#	G400 second head (depends FB_MATROX_GXXX, FB_MATROX_I2C)
			 (sets FB_MATROX_G450)
#	G450/550 support (depends on FB_MATROX_GXXX)

Roger
