Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbUBTPvU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUBTPvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:51:19 -0500
Received: from ns.suse.de ([195.135.220.2]:62684 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261295AbUBTPvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:51:13 -0500
To: Valdis.Kletnieks@vt.edu
Cc: Matthew Wilcox <willy@debian.org>, davidm@hpl.hp.com, torvalds@osdl.org,
       Michel D?nzer <michel@daenzer.net>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: radeon warning on 64-bit platforms
References: <1077054385.2714.72.camel@thor.asgaard.local>
	<16434.36137.623311.751484@napali.hpl.hp.com>
	<1077055209.2712.80.camel@thor.asgaard.local>
	<16434.37025.840577.826949@napali.hpl.hp.com>
	<1077058106.2713.88.camel@thor.asgaard.local>
	<16434.41884.249541.156083@napali.hpl.hp.com>
	<20040217234848.GB22534@krispykreme>
	<16434.46860.429861.157242@napali.hpl.hp.com>
	<20040218015423.GH11824@parcelfarce.linux.theplanet.co.uk>
	<16434.50928.682219.187846@napali.hpl.hp.com>
	<20040218022831.GI11824@parcelfarce.linux.theplanet.co.uk>
	<200402192230.i1JMUifj004565@turing-police.cc.vt.edu>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  does your DRESSING ROOM have enough ASPARAGUS?
Date: Fri, 20 Feb 2004 16:51:00 +0100
In-Reply-To: <200402192230.i1JMUifj004565@turing-police.cc.vt.edu> (Valdis
 Kletnieks's message of "Thu, 19 Feb 2004 17:30:44 -0500")
Message-ID: <jehdxl697f.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu writes:

> [/usr/src/linux-2.6.3-mm1/arch/i386]2 find . -name '*.c' | xargs cat |sed 's/\t/        /g'| awk 'length() > 80 { print $0}' | wc -l
>    1291
>
> (replace \t with whatever your shell needs to enter a literal tab .  Yes, this
> botches on the relatively rare line that has an embedded tab. Deal with it. ;).

Use expand.

$ find . -name '*.c' | xargs cat | expand | awk 'length() > 80 { print $0}' | wc -l
1125

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
