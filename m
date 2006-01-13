Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422990AbWAMV5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422990AbWAMV5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422992AbWAMV5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:57:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:50569 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422990AbWAMV5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:57:34 -0500
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple
	PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
       linux-kernel@killerfox.forkbomb.ch, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <1137189319.4854.12.camel@localhost.localdomain>
References: <20051225212041.GA6094@hansmi.ch>
	 <1137022900.5138.66.camel@localhost.localdomain>
	 <20060112000830.GB10142@hansmi.ch>
	 <200601122312.05210.dtor_core@ameritech.net>
	 <1137189319.4854.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 14 Jan 2006 08:57:14 +1100
Message-Id: <1137189435.4854.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-14 at 08:55 +1100, Benjamin Herrenschmidt wrote:

> 
> > > +		try_translate = test_bit(usage->code, usbhid_pb_numlock)?1:
> > > +				test_bit(LED_NUML, input->led);
> > > +		if (try_translate) {
> > 
> > Isn't this the same as 
> > 
> > 		if (test_bit(usage->code, usbhid_pb_numlock) || test_bit(LED_NUML, input->led))
> > 
> > but harder to read?
> 
> No. If the first one is 0, the second one will not matter in the first
> version, while it will in yours.

Forget me, I'm stupid or rather I should finish by breakfast before
writing stupid things ;) Of course you are right, they are equivalent.

Ben.


