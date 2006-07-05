Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWGETjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWGETjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 15:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWGETjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 15:39:55 -0400
Received: from colin.muc.de ([193.149.48.1]:42258 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S965008AbWGETjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 15:39:54 -0400
Date: 5 Jul 2006 21:39:52 +0200
Date: Wed, 5 Jul 2006 21:39:52 +0200
From: Andi Kleen <ak@muc.de>
To: Doug Thompson <norsk5@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org, eric biederman <ebiederman@lnxi.com>
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
Message-ID: <20060705193952.GA83806@muc.de>
References: <20060704092358.GA13805@muc.de> <20060705173950.5349.qmail@web50103.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060705173950.5349.qmail@web50103.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok since you didn't cover it I assume you agree that just using
the address to get the DIMM is sufficient. Thanks.

> Our LinuxBIOS engineers have found that the majority of the DMI/SMBIOS
> tables are incorrect and provide a false sense of security in terms of
> getting the right information that is needed in finding failing devices
> (DIMMs).

Hmm, I found a few outlyers[1] but most systems I checked were 
reasonable or had only small problems. I could however not 
always verify the mappings by pulling out DIMMs. 

Anyways why does LinuxBIOS not just supply a DMI table? Would 
seem to me like a vastly more elegant solution than requiring
something in user space to identify the system in other ways.

I don't even want to guess how you identify systems without
a DMI table ...

[1] A few not to be named but well known vendors seem to be too lazy
to set the tables up properly and always mapped all addresses to all DIMMs. 
Since it's a serious RAS disadvantage for their systems I suppose
angry customers will sooner or later fix that issue though.


> Our users demand 100% correct DIMM labeling for error fault isolation,
> with minimal manual operation - that is the requirement we are trying
> to satisfy. These items are what lead to the Bluesmoke/EDAC labeling
> solution pattern.

Ok I can see that. But it makes it a very narrow solution because
other people don't know as much about their hardware as you do.

For mainline Linux we should try to focus support on standard mainstream PC 
hard&firm&software, not custom systems like you seem to attempt to.

If you find wrong SM tables to be a serious problem I guess
it would be possible to add a way to overwrite them in mcelog.

Anyways you haven't described anything so far that the existing
machine check handler/mcelog cannot do (mcelog with some small tweaks) 

-Andi
