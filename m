Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVEJXRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVEJXRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 19:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVEJXRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 19:17:47 -0400
Received: from [212.44.21.72] ([212.44.21.72]:29120 "EHLO watergate.zeus.co.uk")
	by vger.kernel.org with ESMTP id S261822AbVEJXR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:17:26 -0400
Subject: Re: ALPS touchpad issues still exist in 2.6.12-rc4
From: Stuart Shelton <stuart@zeus.com>
To: dtor_core@ameritech.net
Cc: Daniel Drake <dsd@gentoo.org>, linux-kernel@vger.kernel.org,
       Alan Lake <alan.lake@lakeinfoworks.com>, petero2@telia.co.uk,
       vojtech@suse.cz
In-Reply-To: <d120d5000505101520ad1761@mail.gmail.com>
References: <42801AEE.5080308@lakeinfoworks.com>
	 <200505092305.45788.dtor_core@ameritech.net> <42812E89.4070301@gentoo.org>
	 <d120d5000505101520ad1761@mail.gmail.com>
Content-Type: text/plain
Organization: Zeus Technology Ltd.
Date: Wed, 11 May 2005 00:17:18 +0100
Message-Id: <1115767038.12779.36.camel@callisto.dnsalias.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1DVdyU-0003ha-00*rEz/R.uFPL.* (Zeus Technology Ltd)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 17:20 -0500, Dmitry Torokhov wrote:
> On 5/10/05, Daniel Drake <dsd@gentoo.org> wrote:
> > Hi,
> > 
> > Dmitry Torokhov wrote:
> > > Do you have an ALPS touchpad? Try applying Peter Osterlund's patches
> > > from here:
> > >
> > > http://web.telia.com/~u89404340/patches/touchpad/2.6.11/
> > 
> > Even with these patches applied, some Gentoo users are still reporting
> > problems with ALPS touchpads. Are there any suggested solutions for
> > http://bugzilla.kernel.org/show_bug.cgi?id=4281 ?
> 
> For tap-and-drag support and to control topuchpad's sensitivity you
> would need to install Synaptics X driver (and/or updated GPM with
> evedev support).
> 

Hi,

I've been testing this on my laptop in framebuffer console mode only -
I've not tested the Synaptics driver with the newer kernels.

I'm not sure if an updated GPM is the right solution: tapping does very
occasionally seem to work (although it might be some facet of the bug
that sometimes causes the cursor to appear and select the character
beneath it when typing).

More than this, with every kernel (at least since the very early 2.4
ones) up to 2.6.10 the ALPS touchpad has worked just fine through
input/mice or the psaux device - why has this changed in 2.6.11, and can
the change be reverted before 2.6.12 is released?

The principal of least surprise would suggest that effectively breaking
the input device driver for an entire class of hardware should be
avoided if at all possible...

Cheers,

	Stuart

