Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVLFRKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVLFRKq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVLFRKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:10:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:23693 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932437AbVLFRKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:10:44 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Reading /proc/stat is slooow
References: <B8E391BBE9FE384DAA4C5C003888BE6F05204A1E@scsmsx401.amr.corp.intel.com>
	<894E37DECA393E4D9374E0ACBBE7427003BC9642@pdsmsx402.ccr.corp.intel.com>
	<20051206165800.GA6277@agluck-lia64.sc.intel.com>
X-Yow: Why are these athletic shoe salesmen following me??
Date: Tue, 06 Dec 2005 18:10:40 +0100
In-Reply-To: <20051206165800.GA6277@agluck-lia64.sc.intel.com> (Tony Luck's
	message of "Tue, 6 Dec 2005 08:58:00 -0800")
Message-ID: <jeslt6xib3.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:

> 2) The problem loop is already #ifdef'd out for PPC64 and ALPHA.  We could add
> IA64 to that exclusive club and just not include the per irq sums.  Since kstat_irqs()
> computes the sums in an "int", they will wrap frequently on a large system
> (512 cpus * default 250Hz = 128000 ... which wraps a 32-bit unsigned in 9 hours
> and 19 minutes) ... so their usefulness is questionable.  Does xosview use
> the per-irq values?

It doesn't use them, it uses /proc/interrupts instead.  So IMHO this would
be the preferred solution.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
