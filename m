Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVBMKGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVBMKGf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 05:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVBMKGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 05:06:32 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:28114 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S261258AbVBMKG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 05:06:28 -0500
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
From: Kenan Esau <kenan.esau@conan.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, harald.hoyer@redhat.de,
       lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <1108230392.4056.100.camel@localhost.localdomain>
References: <20050211201013.GA6937@ucw.cz>
	 <1108227679.12327.24.camel@localhost>
	 <1108230392.4056.100.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 10:39:46 +0100
Message-Id: <1108287586.5978.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, den 12.02.2005, 12:46 -0500 schrieb Arjan van de Ven:
> On Sat, 2005-02-12 at 18:01 +0100, Kenan Esau wrote:
> 
> > Second thing is that I am not shure that it is a good idea to integrate
> > the lbtouch-support into the psmouse-driver since there is no real way
> > of deciding if the device you are talking to is REALLY a
> > lifebook-touchsreen or not. 
> ...
> > IMHO the driver should be standalone and the user should decide which
> > driver he wants to use. As default the touchscreen-functionality will be
> > disabled and only the quick-point device will work like a normal
> > PS2-mouse.
> 
> I just want to point out that this is a problem for distributions and
> for not-so-technical users.
> 
> Is there *really*  no way to know if you're on a lifebook? Can't you use
> say the DMI identification mechanism to find this out ? If so, I think
> integrating into the regular driver very much is the right thing to
> do... it makes things JustWork(tm) for users without any need for manual
> configuration (which also makes distribution makers happy).

Yes that would be nice. But the lifebook-touchscreen hardware is also
used in other notebooks. For example the Panasonic Toughbook CF28. But
we could still use DMI to check whether we are on a lifebook b-series
and then initialize the hardware. This would still get 95% of all cases.
For all the other ones we would have to provide some kind of
force-switch.

