Return-Path: <linux-kernel-owner+w=401wt.eu-S1751161AbWLLFMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWLLFMe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 00:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWLLFMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 00:12:34 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:45257 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbWLLFMd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 00:12:33 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAHbIfUVKhQ0nVWdsb2JhbACNSgEr
From: Dmitry Torokhov <dtor@insightbb.com>
To: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: [RFC] rfkill - Add support for input key to control wireless radio
Date: Tue, 12 Dec 2006 00:12:25 -0500
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       John Linville <linville@tuxdriver.com>, Jiri Benc <jbenc@suse.cz>,
       Lennart Poettering <lennart@poettering.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Larry Finger <Larry.Finger@lwfinger.net>
References: <200612031936.34343.IvDoorn@gmail.com> <d120d5000612061404x3f6e18e7qd3601c3b450a5f91@mail.gmail.com> <200612072253.14492.IvDoorn@gmail.com>
In-Reply-To: <200612072253.14492.IvDoorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612120012.28911.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivo,

On Thursday 07 December 2006 16:53, Ivo van Doorn wrote:
> Hi,
> 
> > > > >  2 - Hardware key that does not control the hardware radio and does not report anything to userspace
> > > >
> > > > Kind of uninteresting button ;)
> > >
> > > And this is the button that rfkill was originally designed for.
> > > Laptops with integrated WiFi cards from Ralink have a hardware button that don't send anything to
> > > userspace (unless the ACPI event is read) and does not directly control the radio itself.
> > >
> > 
> > So what does such a button do? I am confused here...
> 
> Without a handler like rfkill, it does nothing besides toggling a bit in a register.
> The Ralink chipsets have a couple of registers that represent the state of that key.
> Besides that, there are no notifications to the userspace nor does it directly control the
> radio.
> That is where rfkill came in with the toggle handler that will listen to the register
> to check if the key has been pressed and properly process the key event.

In this case the driver can make the button state available to userspace so
thsi is really type 2) driver as far as I can see. The fact that the button
is not reported to userspace yet should not get into our way of classifying
it.

-- 
Dmitry
