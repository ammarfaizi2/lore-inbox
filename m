Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWEFSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWEFSKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWEFSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:10:05 -0400
Received: from khc.piap.pl ([195.187.100.11]:36620 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751022AbWEFSKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:10:03 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Greg KH" <greg@kroah.com>,
       "Ian Romanick" <idr@us.ibm.com>, "Dave Airlie" <airlied@linux.ie>,
       "Arjan van de Ven" <arjan@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace (Xorg) to enable devices without doing foul direct access
References: <mj+md-20060504.211425.25445.atrey@ucw.cz>
	<20060505202603.GB6413@kroah.com>
	<9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	<20060505210614.GB7365@kroah.com>
	<9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	<20060505222738.GA8985@kroah.com>
	<9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	<21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
	<9e4733910605052039n7d2debbse0fd07e0d1d059fb@mail.gmail.com>
	<m3d5er729f.fsf@defiant.localdomain>
	<9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 06 May 2006 20:10:01 +0200
In-Reply-To: <9e4733910605060608l57c1a215pa300c326ef1eef4b@mail.gmail.com> (Jon Smirl's message of "Sat, 6 May 2006 09:08:28 -0400")
Message-ID: <m34q036n46.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Substitute vga with the name of whatever class of device you are
> working on and build it a minimal driver for it. The technique is
> generic.

The card in question _has_ a driver. I, for example, just need a way
to write EEPROM data to it (vendor/device ID etc). The card has to be
selected by PCI bus and slot (device) number, not by device class
and/or IDs, because it can contain garbage and/or some generic IDs
with generic device class.

I'm not against the additional driver but it has to be able to work
with any specified card (as setpci does). But if it's that simple
then why not do that in the PCI code instead (holding some device
file open isn't a problem)?
-- 
Krzysztof Halasa
