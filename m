Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbUBVWDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 17:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbUBVWDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 17:03:21 -0500
Received: from gprs147-171.eurotel.cz ([160.218.147.171]:12420 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261762AbUBVWDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 17:03:16 -0500
Date: Sun, 22 Feb 2004 23:03:00 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Willy Tarreau <willy@w.ods.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.25-rc4
Message-ID: <20040222220259.GA24668@elf.ucw.cz>
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet> <20040218055744.GC15660@alpha.home.local> <Pine.LNX.4.58L.0402181132480.4852@logos.cnet> <20040220224836.GA32153@elf.ucw.cz> <20040222084153.GA20189@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222084153.GA20189@alpha.home.local>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Your fix looks ok. I dont think calling acpi_system_save_state(S5) can
> > > cause any breakage. Len?
> > 
> > I bet it will create "machine will reboot instead of poweroff" on some
> > strange machine.... Perhaps it fixes more machines than it breaks, but
> > it will probably break some.
> 
> This is interesting. Do you have an idea about what could break
> exactly ?

No, but this is ACPI. No matter how simple change looks, it will break
something.

> In my case, I have noticed two things :
>   - if I disable local APIC, the standard code works
>   - if I enable local APIC, I need the patch above.
> 
> So perhaps it would be enough to disable local APIC instead of calling this
> function ?

Hmm.. that means we need APIC driver model...
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
