Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264955AbUFGRoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbUFGRoJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUFGRoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:44:09 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:60071 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264955AbUFGRoE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:44:04 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Roger Luethi <rl@hellgate.ch>
Date: Mon, 7 Jun 2004 19:43:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Matrox Kconfig
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8A46A014187@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Jun 04 at 13:40, Roger Luethi wrote:
> The descriptions for CONFIG_FB_MATROX_G450 and CONFIG_FB_MATROX_G100A
> in drivers/video/Kconfig (current 2.6) are confusing: Both want to be
> selected for Matrox G100, G200, G400 based video cards.
> 
> In the menu, it's
> 
> # G100/G200/G400/G450/G550 support (sets FB_MATROX_G100, FB_MATROX_G450)
> #   G100/G200/G400 support     (sets FB_MATROX_G100)
> #   G400 second head support
> 
> where the second depends on the first _not_ being selected.
> 
> How about this instead?
> 
> # Gxxx (generic) (sets FB_MATROX_G100)
> #   G400 second head (depends FB_MATROX_GXXX, FB_MATROX_I2C)
>              (sets FB_MATROX_G450)
> #   G450/550 support (depends on FB_MATROX_GXXX)

Please no. It was this way in 2.4.x, and I was receiving at least
two complaints a week that their G450 does not work with their
system.

G400's second head has nothing to do with G450/G550, so there is
no reason why G400 second head should set FB_MATROX_G450...

If anything, then let's remove G100/G200/G400 choice completely,
making G450/G550 support unconditional.
                                            Petr Vandrovec

