Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292475AbSBUPyY>; Thu, 21 Feb 2002 10:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292467AbSBUPyO>; Thu, 21 Feb 2002 10:54:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38667 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292475AbSBUPyD>;
	Thu, 21 Feb 2002 10:54:03 -0500
Message-ID: <3C751819.9B5A88BB@mandrakesoft.com>
Date: Thu, 21 Feb 2002 10:54:01 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Lunz <j@trellisinc.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.44.0202210636020.8696-100000@dlang.diginsite.com> <3C750CCF.989B1FDD@mandrakesoft.com> <20020221154123.GA6543@trellisinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Lunz wrote:
> 
> Jeff Garzik wrote:
> > David Lang wrote:
> >> I'll argue that _not_ doing this violated the principle of lease surprise,
> >> if you turn a feature on and immediatly back off why should anything in
> >> your config be any different then it was before you turned it on?
> >
> > Imagine this case:
> >
> > make xconfig # select CONFIG_USB_HID, which auto-selects CONFIG_INPUT
> > { time passes }
> > make xconfig # de-select CONFIG_USB_HID
> >
> > On the second 'make xconfig', should CONFIG_INPUT be automatically
> > de-selected?  No.  Because that is making the assumption that the person
> > does not want to continue to make the input API available.
> 
> It depends. When CONFIG_USB_HID auto-selected CONFIG_INPUT, did the user
> know about it? Or did it just happen automagically behind the scenes? If
> it was turned on silently, and the subsequent de-select of
> CONFIG_USB_HID silently left CONFIG_INPUT turned on, I'd say that
> violates least-surprise.
> 
> On the other hand, if turning on CONFIG_USB_HID then prompts "to do
> that, I also have to turn on CONFIG_INPUT", i suppose it's ok to leave
> CONFIG_INPUT turned on later.

You do have a point, because there is a small change that a
configuration symbol can be auto-enabled without prompting.

This is more just standard Unix pragmatism, treating auto-remove
operations with far more caution than auto-enable operations, precisely
for cases like the example one above.  Only when one has pretty much
complete control of environment do you want to make the assumption that
a 'remove' op is the perfect complement of the 'add' op.

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
