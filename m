Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263567AbTDNQ5l (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTDNQ5l (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:57:41 -0400
Received: from fmr03.intel.com ([143.183.121.5]:44018 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263564AbTDNQ5j (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:57:39 -0400
Message-ID: <F760B14C9561B941B89469F59BA3A84725A260@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
Date: Mon, 14 Apr 2003 10:09:12 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> - On non-PPC machines, the slot will eventually go to D3, but 
> the APM BIOS or ACPI will be able to re-POST the card 
> properly on wakeup, so the driver only needs to restore the 
> current display mode, at least I guess so since I don't know 
> much about x86's. Similar will happen once I have an OF 
> emulator ready on PPC to re-POST some cards, thus changing 
> the previous example into this one. In this case, the driver 
> can put the chip to D3 and can _accept_ the sleep request 
> because it's explicitely told by the system (how ?) that the 
> card will be re-POSTED prior to the
> resume() callback.

Topic drift...

After asking around internally, it sounds like we should not be doing a
video re-POST on wakeup. Windows only used to in order to workaround
buggy video drivers, according to what I've heard.

Ben obviously PPC is ahead of the pack on this stuff (congrats) but I
did just want to put forward the idea that when we're all done with this
stuff on all archs, we will hopefully not be regularly re-POSTing the
video bios.

Regards -- Andy
