Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264081AbTDWPUV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTDWPUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:20:21 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:21166 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264081AbTDWPUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:20:20 -0400
Date: Wed, 23 Apr 2003 17:29:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Subtle semantic issue with sleep callbacks in drivers
Message-ID: <20030423152927.GB3035@elf.ucw.cz>
References: <F760B14C9561B941B89469F59BA3A84725A260@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A260@orsmsx401.jf.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > - On non-PPC machines, the slot will eventually go to D3, but 
> > the APM BIOS or ACPI will be able to re-POST the card 
> > properly on wakeup, so the driver only needs to restore the 
> > current display mode, at least I guess so since I don't know 
> > much about x86's. Similar will happen once I have an OF 
> > emulator ready on PPC to re-POST some cards, thus changing 
> > the previous example into this one. In this case, the driver 
> > can put the chip to D3 and can _accept_ the sleep request 
> > because it's explicitely told by the system (how ?) that the 
> > card will be re-POSTED prior to the
> > resume() callback.
> 
> Topic drift...
> 
> After asking around internally, it sounds like we should not be doing a
> video re-POST on wakeup. Windows only used to in order to workaround
> buggy video drivers, according to what I've heard.

We really should not be doing that, but we... kind of have to. Thats
why acpi_sleep=s3_bios exists. I really don't know how to work around
it.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
