Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWINOXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWINOXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbWINOXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:23:20 -0400
Received: from us.cactii.net ([66.160.141.151]:44552 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1750791AbWINOXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:23:19 -0400
Date: Thu, 14 Sep 2006 16:22:42 +0200
From: Ben B <kernel@bb.cactii.net>
To: Almonas Petrasevicius <draugaz@diedas.soften.ktu.lt>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com,
       davej@codemonkey.org.uk
Subject: Re: speedstep-centrino broke
Message-ID: <20060914142242.GA28040@cactii.net>
References: <Pine.LNX.4.62.0609141558090.22822@diedas.soften.ktu.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609141558090.22822@diedas.soften.ktu.lt>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Almonas Petrasevicius <draugaz@diedas.soften.ktu.lt> uttered the following thing:
> Hi,
> 
> I experience the same speedstep problem on my HP nc6320 (CoreDuo T2400) 
> since yesterday's BIOS update (F06 to F08).
> 
> According to the release notes this BIOS update should introduce support 
> for the new CPU's (Core2 "Merom" I suppose).
> 
> I did verify both kernels 2.6.16 and 2.6.17 (both vanilla), there is 
> _no_ difference, both have the same speedstep problem.

At the suggestion of Venki, I opened a bugzilla ticket on it:

http://bugzilla.kernel.org/show_bug.cgi?id=7157

And the lowdown is that it seems the newer BIOS no longer exports the
correct ACPI symbols which are required for speedstep, thus no longer
supporting it (at least via the official methods). Hence it seems not a
Linux kernel bug.

I opened a support ticket with HP, hopefully they address the issue. In
the meantime I rolled back my bios and have cpufreq working again.
Interesting that you also see the problem on an nc6320, it could be that
they use the same BIOS codebase for various models.

Ben

