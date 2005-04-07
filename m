Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVDGXNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVDGXNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 19:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVDGXNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 19:13:38 -0400
Received: from ns.suse.de ([195.135.220.2]:47235 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262440AbVDGXNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 19:13:33 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] radeonfb: (#2)  Implement proper workarounds for PLL
 accesses
References: <1110519743.5810.13.camel@gaston>
	<1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	<1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	<1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	<1112914051.9518.306.camel@gaston>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Bagels...
Date: Fri, 08 Apr 2005 01:13:31 +0200
In-Reply-To: <1112914051.9518.306.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 08 Apr 2005 08:47:31 +1000")
Message-ID: <jevf6y6uzo.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Can you cound how many times radeonfb_set_par is called and dump your
> "counter" at the beginning and end of each of these calls ?

Switch from X to console:

kernel: radeonfb_set_par
kernel: radeon_pll_errata_after_data
last message repeated 774 times
kernel: radeonfb_set_par
kernel: radeon_pll_errata_after_data
last message repeated 918 times

Switch from console to X:

kernel: radeonfb_set_par
kernel: radeon_pll_errata_after_data
last message repeated 200 times
kernel: agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
kernel: agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
kernel: radeon_pll_errata_after_data
last message repeated 191 times

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
