Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVDEVvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVDEVvq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVDEVtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:49:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:42974 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262066AbVDEVon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:44:43 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
 accesses
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I'm in DISGUISE as a BAGGAGE CHECKER....I can watch the house, if
 it's
 ORANGE...
Date: Tue, 05 Apr 2005 23:44:35 +0200
In-Reply-To: <1110672745.5787.60.camel@gaston> (Benjamin Herrenschmidt's
 message of "Sun, 13 Mar 2005 11:12:25 +1100")
Message-ID: <je8y3wyk3g.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> After discussion with ATIs, it seems that the workarounds they initially
> gave me were not completely correct.
>
> This patch implements the proper ones, which includes sleeping in PLL
> accesses, and thus requires the previous patch to make sure we do not
> call unblank at interrupt time (unless oops_in_progress is set, in which
> case I use an mdelay).
>
> It also removes obsolete code that used to disable some power management
> features in the accel init code.

This patch does no good on Radeon M6 (iBook G3).  It makes mode switching
to take an extraordinary amount of time, ie. when switching away from X it
takes about 2-3 seconds until the console is restored.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
