Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbWEHEGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbWEHEGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 00:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932283AbWEHEGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 00:06:18 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:15597 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932281AbWEHEGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 00:06:17 -0400
Date: Mon, 8 May 2006 05:06:13 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, Ian Romanick <idr@us.ibm.com>,
       Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
 userspace (Xorg) to enable devices without doing foul direct access
In-Reply-To: <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605080503001.6291@skynet.skynet.ie>
References: <mj+md-20060504.211425.25445.atrey@ucw.cz> 
 <9e4733910605041438q5bf3569bs129bf2e8851b7190@mail.gmail.com> 
 <1146784923.4581.3.camel@localhost.localdomain>  <445BA584.40309@us.ibm.com>
  <9e4733910605051314jb681476y4b2863918dfae1f8@mail.gmail.com> 
 <20060505202603.GB6413@kroah.com>  <9e4733910605051335h7a98670ie8102666bbc4d7cd@mail.gmail.com>
  <20060505210614.GB7365@kroah.com>  <9e4733910605051415o48fddbafpf0f8b096f971e482@mail.gmail.com>
  <20060505222738.GA8985@kroah.com> <9e4733910605051705j755ad61dm1c07c66c2c24c525@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So as a result of this every interrupt service routine should now
> include pci_enable(). If you don't include this and someone from user
> space disables the hardware you're going to GPF. fbdev is already
> forced to take defensive measures like this since X will randomly
> disable it's hardware while it has an ISR active.

Jon please stop spouting crap at least, every ISR doesn't need pci_enable, 
as it doesn't need it now, you are NOT listening, adding the enable bit 
DOES NOT change things, if someone runs setpci from userspace now they can 
do this, ROOT CAN CRASH YOUR MACHINE, FILM AT 11.

If you enable the rom at the moment you can crash things, some devices 
don't have enough address decoders to decode a bar and the ROM, so me 
enabling ROM decoding as your original patch did, can cause system 
lockups,

why is this different, why didn't you write the ROM code patch properly 
then and we woulnd't have to to hear about it now...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

