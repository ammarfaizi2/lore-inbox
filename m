Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933467AbWKNSiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933467AbWKNSiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933468AbWKNSiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:38:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:38060 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933467AbWKNSiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:38:51 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, adurbin@google.com
Subject: Re: [PATCH for 2.6.19] [6/9] x86_64: Update MMCONFIG resource insertion to check against e820 map.
References: <20061114508.445749000@suse.de>
	<20061114160856.D02D113C69@wotan.suse.de>
From: Andi Kleen <ak@suse.de>
Date: 14 Nov 2006 19:38:49 +0100
In-Reply-To: <20061114160856.D02D113C69@wotan.suse.de>
Message-ID: <p73irhhdgau.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> From: "Aaron Durbin" <adurbin@google.com>
> Check to see if MMCONFIG region is marked as reserved in the e820 map before
> inserting the MMCONFIG region into the resource map. If the region is not
> entirely marked as reserved in the e820 map attempt to find a region that is.
> Only insert the MMCONFIG region into the resource map if there was a region
> found marked as reserved in the e820 map.  This should fix a known regression
> in 2.6.19 by not reserving all of the I/O space on misconfigured systems.


[...]

Before anyone complains. This one patch is actually not in, because
Linus' decision was it instead to revert the mcfg reservation
code for .19. He already did it for i386 and i followed on x86-64.
But this patch went into the posted patchkit by mistake.
Will be probably revisited for .20.

-Andi
