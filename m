Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVD1AAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVD1AAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 20:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVD1AAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 20:00:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:11708 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262108AbVD1AAl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 20:00:41 -0400
Date: Wed, 27 Apr 2005 17:01:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joe <joecool1029@gmail.com>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: Device Node Issues with recent mm's and udev
Message-Id: <20050427170106.782ea4c3.akpm@osdl.org>
In-Reply-To: <d4757e6005042716523af66bae@mail.gmail.com>
References: <d4757e6005042716523af66bae@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe <joecool1029@gmail.com> wrote:
>
> This issue started to appear in around the 2.6.11-mm series.. it
> continues even now with 2.6.12-rc2-mm3.
> 
> Attempting to copy an image to a device with a tool like dd, results
> in the device node being overwritten with the data, but the data is
> never sent to the destination drive for instance.
> 
> To try to put it more plainly, I have a firmware image I am copying to
> an ipod.  Normally the image sends with no issues and the ipod has the
> new firmware.
> 
> With the recent mm's it treats the device node as a file and ls -l
> will show the size of the image as the size of the device node.
> 
> Even things like fdisk are useless.  I am not sure whether this is
> some sort of a udev crash or a problem with usb-storage.  Nevertheless
> it is a problem, and it continues to happen.
> 
> The last non-affected mm i can think of is 2.6.11-rc4-mm1.. though I'm
> fairly sure rc5 is good too.

Greg stuff.

Is the device node in /dev actually a block-special device, or is is coming
up as a regular file or something?

We might have fixed this.  Please retest next -mm, which right now is
looking to be ~30 hours away.

