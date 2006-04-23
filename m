Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWDWOQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWDWOQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWDWOQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 10:16:08 -0400
Received: from styx.suse.cz ([82.119.242.94]:52445 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751339AbWDWOQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 10:16:05 -0400
Date: Sun, 23 Apr 2006 16:16:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org, dtor_core@ameritech.net
Subject: Re: usbkbd not reporting unknown keys
Message-ID: <20060423141622.GB12611@suse.cz>
References: <305c16960603141510g72def22bmd0043d5f71d9ef6@mail.gmail.com> <305c16960604221111u714bd3b1h2aeb0559b07d911b@mail.gmail.com> <20060422185402.GC10613@suse.cz> <305c16960604221259g4ddabca2o6333f7ffcaff8e4f@mail.gmail.com> <20060422200455.GA10994@suse.cz> <305c16960604221401k4e6493b6xa9c898a92c6b028d@mail.gmail.com> <20060422215356.GA11798@suse.cz> <305c16960604221528i2407e2d5nb8aa97c011246e71@mail.gmail.com> <20060423065818.GA12611@suse.cz> <305c16960604230700y7e6931b3pc6cbf042e793e8ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305c16960604230700y7e6931b3pc6cbf042e793e8ad@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2006 at 11:00:45AM -0300, Matheus Izvekov wrote:
> On 4/23/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >
> > Yes, this one looks much better.
> >
> > The keyboard part of the device is OK, but the multimedia/mouse part is
> > totally FUBAR. Adding support for any keys that are not making it
> > through should be trivial, but making it not appear as a crazy joystick
> > is not realistically possible: The device insists on that it IS a device
> > from hell with almost all possible valuators defined in the HID spec.
> >
> > --
> > Vojtech Pavlik
> > Director SuSE Labs
> >
> 
> Yes, its totally crap, should have know better before buying it : /
> But isnt it possible to create a blacklist for it, so the hid driver
> would ignore those valuators?
> Thats what devices with broken implementations deserve : )
 
A better option would be to provide an alternate (corrected) HID
descriptor for it. We already patch the HID descriptor of one keyboard,
so maybe to have generic descriptor replacement support in hid-core
would make sense.

-- 
Vojtech Pavlik
Director SuSE Labs
