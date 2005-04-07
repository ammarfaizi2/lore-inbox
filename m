Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVDGHhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVDGHhU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbVDGHhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:37:20 -0400
Received: from colin2.muc.de ([193.149.48.15]:57616 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261842AbVDGHhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:37:14 -0400
Date: 7 Apr 2005 09:37:13 +0200
Date: Thu, 7 Apr 2005 09:37:13 +0200
From: Andi Kleen <ak@muc.de>
To: Christopher Allen Wing <wingc@engin.umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: clock runs at double speed on x86_64 system w/ATI RS200 chipset (workaround for APIC mode?)
Message-ID: <20050407073713.GA74220@muc.de>
References: <200504031231.j33CVtHp021214@harpo.it.uu.se> <Pine.LNX.4.58.0504041050250.32159@hammer.engin.umich.edu> <m18y3x16rj.fsf@muc.de> <Pine.LNX.4.58.0504051351200.13242@hammer.engin.umich.edu> <20050405183141.GA27195@muc.de> <Pine.LNX.4.58.0504061758150.4573@hammer.engin.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504061758150.4573@hammer.engin.umich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm still seeing 'APIC error on CPU0: 00(40)' messages from time to time.

Thanks for the analysis. The clear_IO_APIC_pin looks quite hackish,
I am not sure I want to put that into the mainline kernel.
The APIC errors are also suspicious.

I don't want to blacklist ATI from just a single report,
but if there are more it is probably best to just disable
the IO-APIC by default there for now.

-Andi


