Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262248AbVDFRO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbVDFRO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVDFRO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:14:58 -0400
Received: from inutil.org ([193.22.164.111]:9913 "EHLO
	vserver151.vserver151.serverflex.de") by vger.kernel.org with ESMTP
	id S262248AbVDFROp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:14:45 -0400
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org
Subject: Re: Linux 2.6.12-rc2
In-Reply-To: <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
Date: Wed, 6 Apr 2005 19:14:35 +0200
Message-Id: <E1DJE6t-0001T5-UD@localhost.localdomain>
From: Moritz Muehlenhoff <jmm@inutil.org>
X-SA-Exim-Connect-IP: 84.137.114.145
X-SA-Exim-Mail-From: jmm@inutil.org
X-SA-Exim-Scanned: No (on vserver151.vserver151.serverflex.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Benjamin Herrenschmidt:
>   o radeonfb: Implement proper workarounds for PLL accesses
>   o radeonfb: DDC i2c fix
>   o radeonfb: Fix mode setting on CRT monitors
>   o radeonfb: Preserve TMDS setting

One of these patches introduced two regressions on my Thinkpad X31 with
"ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])":

1. When resuming from S3 suspend and having switched off the backlight
with radeontool the backlight isn't switched back on any more.

2. I'm using fbcon as my primary work environment, but tty switching has
become _very_ sloppy, it's at least a second now, while with 2.6.11 it
was as fast as a few ms. Is this caused by the "proper PLL accesses"?

Cheers,
        Moritz
