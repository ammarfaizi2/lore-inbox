Return-Path: <linux-kernel-owner+w=401wt.eu-S1750962AbWLLHrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWLLHrL (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 02:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWLLHrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 02:47:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:59294 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbWLLHrJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 02:47:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gxPXheZKl1wY3S+XfQhyztvyt669r7f+3jpzGfVMuP9Bi3q45MGHkPptk36JE3naSwD1NK22jAa+gsLw0G7ijt4OnfZMrBjhjvSIwdy4LAeOBKNhSut1U3wkh0Gq159kUoGWYDQ1bEuH7Kn8yRECb7yYU7t5ofmfhgX/LT+vQQ4=
Message-ID: <a32f33a40612112347hd359ca5q5962e12301d31bd6@mail.gmail.com>
Date: Tue, 12 Dec 2006 08:47:07 +0100
From: "Ivo Van Doorn" <ivdoorn@gmail.com>
To: "Dmitry Torokhov" <dtor@insightbb.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "John Linville" <linville@tuxdriver.com>, "Jiri Benc" <jbenc@suse.cz>,
       "Lennart Poettering" <lennart@poettering.net>,
       "Johannes Berg" <johannes@sipsolutions.net>,
       "Larry Finger" <Larry.Finger@lwfinger.net>
In-Reply-To: <200612120012.28911.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200612031936.34343.IvDoorn@gmail.com>
	 <d120d5000612061404x3f6e18e7qd3601c3b450a5f91@mail.gmail.com>
	 <200612072253.14492.IvDoorn@gmail.com>
	 <200612120012.28911.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > > > > > 2 - Hardware key that does not control the hardware radio and does not report anything to userspace
> > > > >
> > > > > Kind of uninteresting button ;)
> > > >
> > > > And this is the button that rfkill was originally designed for.
> > > > Laptops with integrated WiFi cards from Ralink have a hardware button that don't send anything to
> > > > userspace (unless the ACPI event is read) and does not directly control the radio itself.
> > > >
> > >
> > > So what does such a button do? I am confused here...
> >
> > Without a handler like rfkill, it does nothing besides toggling a bit in a register.
> > The Ralink chipsets have a couple of registers that represent the state of that key.
> > Besides that, there are no notifications to the userspace nor does it directly control the
> > radio.
> > That is where rfkill came in with the toggle handler that will listen to the register
> > to check if the key has been pressed and properly process the key event.
>
> In this case the driver can make the button state available to userspace so
> thsi is really type 2) driver as far as I can see. The fact that the button
> is not reported to userspace yet should not get into our way of classifying
> it.

I was indeed considering it as a type 2) device.
I am currently working on revising the rfkill driver to work as you suggested,
so I hope to have a new patch ready for you soon.

Ivo
