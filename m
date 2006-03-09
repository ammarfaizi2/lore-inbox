Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751909AbWCINnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWCINnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCINnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:43:14 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:53752 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751909AbWCINnN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:43:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=INlIOuGOS6oXo9CQzF2zrN3UMpix0TDpjlmueoVDHNhdJYtBHHHY/Hi/6JtPy7c2y99B+0AY/eVnmYrEzzYDJre+YIDDmF3jcf526AdR3dGPupXe1wKiAKgoz2LmXbTB9zWM556KqFrlyocbM7RfYM6WuxySnwcSJraeQsoOGeg=
Message-ID: <d120d5000603090543p3446b4a0sddaaa031ad2513ca@mail.gmail.com>
Date: Thu, 9 Mar 2006 08:43:12 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Matheus Izvekov" <mizvekov@gmail.com>
Subject: Re: usbkbd not reporting unknown keys
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <305c16960603081130g5367ddb3m4cbcf39a9253a087@mail.gmail.com>
	 <305c16960603081225m68c26ff7wd3b73621cfb81d9a@mail.gmail.com>
	 <d120d5000603081247i69f9e7dbm6ef614f50140227f@mail.gmail.com>
	 <305c16960603081334k25ce9a89g132876d4c9246fc6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Matheus Izvekov <mizvekov@gmail.com> wrote:
>
> It works, except that i have some multimedia keys which are not
> mapped. Im going to add those to the table soon, thats why i needed
> those messages.

Please change #undef DEBUG to #define DEBUG in
drivers/usb/input/hid-input.c and send me dmesg - we want to map those
key in HID driver if we can.

> So you think the usbkbd behaviour is the correct one,
> and the default behaviour must be changed in the atkbd driver?
>

No, not really. atkbd is a recommended (and only) driver when
connecting PS/2 keyboards. We do want user to know how to set up
additional keys, if any. usbkbd driver is only to be used when there
are issues with full HID driver. It will only provide "standard" keys
and is not expected to be modified.

--
Dmitry
