Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbWE2Oiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWE2Oiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 10:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWE2Oiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 10:38:55 -0400
Received: from ns2.suse.de ([195.135.220.15]:48517 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750962AbWE2Oiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 10:38:54 -0400
Message-ID: <447B076D.5000504@suse.de>
Date: Mon, 29 May 2006 16:38:37 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Linux and Kernel Video <video4linux-list@redhat.com>
Cc: Michael Hunold <hunold@linuxtv.org>, Jiri Slaby <jirislaby@gmail.com>,
       linux-kernel@vger.kernel.org, Nathan Laredo <laredo@gnu.org>,
       Christer Weinigel <christer@weinigel.se>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] Re: Stradis driver conflicts with	all	other
 SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>	<1148825088.1170.45.camel@praia>	<d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>	<1148837483.1170.65.camel@praia>  <m3k686hvzi.fsf@zoo.weinigel.se>	<1148841654.1170.70.camel@praia>  <447AED3B.4070708@linuxtv.org>	<1148909606.1170.94.camel@praia>  <447AFA88.1010700@linuxtv.org> <1148911139.1170.99.camel@praia>
In-Reply-To: <1148911139.1170.99.camel@praia>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Since these cards don't have subvendor/subdevice IDs, it's impossible to
>> find out which card is in the system.
> 
> We have two tasks:
> 
> 1) Integrate your code and Nathan one;
> 
> 2) create a generic handler for all saa7146 boards, moving all PCI probe
> to the newer module. After detecting the card number, it should request
> the specific module.

Well, that doesn't solve the fundamental problem that you can't get it
right without help of the user.  Maybe the best solution would be that
no driver is allowed to occupy a device without subsystem id unless
explicitly asked by the user to do so (that would also a good idea for
bttv btw).  A small PCI probing module would be one way to do that, but
it is certainly not the only one.  You could also do something like
adding a pcislot=... insmod option to the existing drivers.

just my 2 cent,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
