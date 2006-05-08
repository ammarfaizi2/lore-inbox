Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWEHOys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWEHOys (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWEHOys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:54:48 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:5305 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932269AbWEHOyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:54:47 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Arjan van de Ven <arjan@linux.intel.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Pavel Machek <pavel@suse.cz>, Dave Airlie <airlied@gmail.com>,
       Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
In-Reply-To: <CF99669B-7F47-4290-9F1E-A9585D7CD8D4@mac.com>
References: <1146784923.4581.3.camel@localhost.localdomain>
	 <445BA584.40309@us.ibm.com>
	 <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com>
	 <20060505202603.GB6413@kroah.com>
	 <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
	 <20060505210614.GB7365@kroah.com>
	 <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
	 <20060505222738.GA8985@kroah.com>
	 <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
	 <21d7e9970605051857l4415a04ai7d1b1f886bb01cee@mail.gmail.com>
	 <20060507131201.GC5765@ucw.cz>
	 <CF99669B-7F47-4290-9F1E-A9585D7CD8D4@mac.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 May 2006 16:54:27 +0200
Message-Id: <1147100067.2888.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> *Especially* since there are a number of users (including myself) who  
> have tendencies to go wandering around sysfs tinkering with the  
> available values.  Not having seen this thread, I would have had no  
> problem doing "echo -n 0 >enable" on some device thinking that it was  
> a fairly standard way to turn off the power to my soundcard 

it is

> when I'm  
> not using it, and likely result in a kernel panic because I suddenly  
> disabled the BARs on the device out from under the driver.

well it is in the pci dir, not in the sound dir. You know you're not
using the driver layer at that point, but are directly poking the
hardware. Just like the resources (eg the contents of the bars) are in
that same directory... you're not echo;ing random crap into those as
well, are you?
