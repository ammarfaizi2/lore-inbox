Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUHSQtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUHSQtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUHSQtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:49:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:8334 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266547AbUHSQtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:49:43 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Corey Minyard <minyard@acm.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be
 registered
References: <4124BACB.30100@acm.org>
	<16676.51035.924323.992044@alkaid.it.uu.se> <4124D25C.20703@acm.org>
	<16676.54504.957712.269455@alkaid.it.uu.se>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Yow!  Did something bad happen or am I in a drive-in movie??
Date: Thu, 19 Aug 2004 18:45:58 +0200
In-Reply-To: <16676.54504.957712.269455@alkaid.it.uu.se> (Mikael
 Pettersson's message of "Thu, 19 Aug 2004 18:27:20 +0200")
Message-ID: <jek6vvvzy1.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Which is the same as saying it occurs on the negative-to-non-negative
> transition. The "if ((int)low >= 0)" test is just a test and branch
> on sign, while your original requires either a (microcoded?) bit op,
> or constructing a large-magnitude mask, followed by some tests.

gcc should be able to convert one into the other depending on which one is
faster.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
