Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbVKWPNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVKWPNB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 10:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbVKWPNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 10:13:01 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:60755 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750966AbVKWPM7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 10:12:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y8grOUbd4wTwUIYO/FFDYGTyurCK9J04B/5L/m7g+jNQ66y9xR5ALzrRneZzVs2nRzpMvyl5OBWzBIwTt7VkYh0oOWovpuV6v7rklziTMvmTDG2G3CjF68AGTJf31z4lEThW6cVk0JNpOyW+GJZJwgdLWKAY/7MWe+cp0BQEdJA=
Message-ID: <9e4733910511230712y2b394851rc17fa71c6f9c6ecf@mail.gmail.com>
Date: Wed, 23 Nov 2005 10:12:58 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Christmas list for the kernel
In-Reply-To: <20051123150349.GA15449@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910511221031o44dd90caq2b24fbac1a1bae7b@mail.gmail.com>
	 <20051122204918.GA5299@kroah.com>
	 <9e4733910511221313t4a1e3c67wc7b08160937eb5c5@mail.gmail.com>
	 <20051123121726.GA7328@ucw.cz>
	 <9e4733910511230643j64922738p709fecd6c86b4a95@mail.gmail.com>
	 <20051123150349.GA15449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Plus I have 64 tty devices. Couldn't the tty devices be created
> > dynamically as they are consumed? Same for the loop and ram devices?
>
> You do realise that the dynamic device creation for those 64 console
> devices is done via the console device being _opened_ by userspace?
>
> Hence, if the device doesn't exist in userspace, it can't be created
> for userspace to open it to create the device via udev.  Have you
> noticed a catch-22 with that statement?

Couldn't we create tty0-3 and then when one of those gets opened,
create tty4, and so on? Then there would always be two or three more
tty devices than there are open tty devices.

>
> Note that with tty devices, the tty layer has to be told the number
> of devices you want to support when you first register your driver.
> You're fixed to that maximum number from that point on, until you
> unregister *all* your ports and driver.
>
> --
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:  2.6 Serial core
>


--
Jon Smirl
jonsmirl@gmail.com
