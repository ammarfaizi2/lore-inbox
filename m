Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSE1W25>; Tue, 28 May 2002 18:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSE1W24>; Tue, 28 May 2002 18:28:56 -0400
Received: from holomorphy.com ([66.224.33.161]:62606 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S290289AbSE1W2z>;
	Tue, 28 May 2002 18:28:55 -0400
Date: Tue, 28 May 2002 15:28:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528222838.GX14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com> <20020528193220.GB189@elf.ucw.cz> <20020528210917.GU14918@holomorphy.com> <20020528211120.GA28189@atrey.karlin.mff.cuni.cz> <20020528212427.GV14918@holomorphy.com> <20020528213408.GE28189@atrey.karlin.mff.cuni.cz> <20020528215318.GW14918@holomorphy.com> <20020528220032.GA3476@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> This looks good, though OTOH if we have a page from a zone we should know
>> the zone exists, and then maybe the if (!curr) check isn't
>> needed. If that's

On Wed, May 29, 2002 at 12:00:32AM +0200, Pavel Machek wrote:
> Good point. Killed.

At some point in the past, I wrote:
>> the case the scary check that almost looks like defensive programming won't
>> be needed at all. Also, is it always expected that this will be a
>> free page?

On Wed, May 29, 2002 at 12:00:32AM +0200, Pavel Machek wrote:
> No. It may be used page, too. That's why it is asking. 
> 								Pavel

Aha, so it can't be a BUG() at the bottom then. Cool, this looks very
nice!

Cheers,
Bill
