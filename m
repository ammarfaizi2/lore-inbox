Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWADPvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWADPvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 10:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWADPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 10:51:18 -0500
Received: from cantor2.suse.de ([195.135.220.15]:44961 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750825AbWADPvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 10:51:17 -0500
From: Andi Kleen <ak@suse.de>
To: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [Patch] es7000 broken without acpi
Date: Wed, 4 Jan 2006 16:40:30 +0100
User-Agent: KMail/1.8.2
Cc: "Peter Hagervall" <hager@cs.umu.se>, "Andrew Morton" <akpm@osdl.org>,
       "Eric Sesterhenn / snakebyte" <snakebyte@gmx.de>,
       linux-kernel@vger.kernel.org
References: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09B4@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B09B4@USRV-EXCH4.na.uis.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041640.30909.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 16:05, Protasevich, Natalie wrote:

> The only possible problem I see with that patch is making genapic
> dependant on ACPI, which I'm not sure about (for example, if Summit
> would want that, but nobody commented back then...Andi, what do you
> think?) As for ES7000, it fixes build problem overall, however, maybe it
> would be prudent to make it builldable even without its dependency on
> ACPI, just for correctness sake, meaning properly #ifdef-ing ACPI parts,
> this will make it more versatile (even though I cannot think of
> situation it might be used...Andi, what do you think? :) 

I haven't looked at it in detail, but likely it's better to 
add the necessary ifdefs to es7000 to compile without ACPI 
than making genapic dependent on ACPI. Not that it makes
that much difference in practice, but it would be cleaner this 
way.

-Andi
