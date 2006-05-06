Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWEFXQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWEFXQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWEFXQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 19:16:28 -0400
Received: from khc.piap.pl ([195.187.100.11]:58119 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751134AbWEFXQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 19:16:27 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Greg KH" <greg@kroah.com>,
       "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	<20060505210614.GB7365@kroah.com>
	<9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	<20060505222738.GA8985@kroah.com>
	<9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	<21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
	<9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com>
	<m3d5er729f.fsf@defiant.localdomain>
	<9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com>
	<m34q036n46.fsf@defiant.localdomain>
	<9e4733910605061124u6b1c4b88nd84faa914c72521f@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 07 May 2006 01:16:25 +0200
In-Reply-To: <9e4733910605061124u6b1c4b88nd84faa914c72521f@mail.gmail.com> (Jon Smirl's message of "Sat, 6 May 2006 14:24:35 -0400")
Message-ID: <m33bfm4ud2.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jon Smirl" <jonsmirl@gmail.com> writes:

>> The card in question _has_ a driver. I, for example, just need a way
>> to write EEPROM data to it (vendor/device ID etc). The card has to be
>> selected by PCI bus and slot (device) number, not by device class
>> and/or IDs, because it can contain garbage and/or some generic IDs
>> with generic device class.
>
> Hardware like you describe violates the PCI spec

What exactly does it violate?

> and it should not be
> expected that Linux will support it in the general case. It sounds
> like this is some kind of prototype hardware.

No. Just one of the final steps of production, or in-system update.

> I would probably handle this by writing an unbound device driver that
> exposes a sysfs file for bus:slot. When you write the bus:slot to the
> file it would then bind to the appropriate hardware and enable it. The
> newly bound driver would support the driver firmware loader interface
> as a means of getting your data in.

What is also needed is that end users perform this task from time to
time. They generally don't want to have to compile the kernel :-)

You know, even now it can be done (entirely in userspace), and only
enabling the device seems a bit dangerous.
-- 
Krzysztof Halasa
