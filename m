Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278004AbRJZHvv>; Fri, 26 Oct 2001 03:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278017AbRJZHvl>; Fri, 26 Oct 2001 03:51:41 -0400
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:46579 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S278004AbRJZHv1>; Fri, 26 Oct 2001 03:51:27 -0400
From: junio@siamese.dhis.twinsun.com
To: Tim Waugh <twaugh@redhat.com>
cc: <daveg@firsdown.demon.co.uk>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <20011024230917.H7544@redhat.com>
	<ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com>
	<20011025165226.T7544@redhat.com>
Date: 26 Oct 2001 00:51:48 -0700
In-Reply-To: <20011025165226.T7544@redhat.com>
Message-ID: <7vofmuu9d7.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "TW" == Tim Waugh <twaugh@redhat.com> writes:

>> Question: is this intended behaviour? I would think that you would
>> normally want to just say irq=auto and let the driver find the io
>> address just as it does normally.

TW> It is intended behaviour.  'irq=auto' in this case didn't help because
TW> the ECP chipset would not tell us what IRQ it was assigned (it just
TW> said "it's set by jumpers, or alternatively I'm not telling you".

This part I do not quite understand.  I have an old laptop that
was working with parport=auto up to 2.4.10 and then stopped
working, just like the original poster's problem description.

>From the original poster's description, 2.4.10 claimed to have
detected both address and irq for parport0, while 2.4.12,
according to the your response, could not tell that IRQ=7.  Do
you mean that the logic which made 2.4.10 to claime to have
detected IRQ=7 was faulty and the logic in 2.4.12 is being
careful not to misdetect?

    Message-ID: <3BD6BF43.D347719B@firsdown.demon.co.uk>
    Date: 	Wed, 24 Oct 2001 14:16:51 +0100
    From: Dave Garry <daveg@firsdown.demon.co.uk>
    Subject: linux-2.4.12 / linux-2.4.13 parallel port problem

    With kernel 2.4.12 and 2.4.13 the parallel port on
    my machine looks like this according to dmesg:

    parport0: PC-style at 0x378 [PCSPP,TRISTATE]
    parport0: cpp_daisy: aa5500ff(98)
    parport0: assign_addrs: aa5500ff(98)
    parport0: faking semi-colon
    parport0: Printer, Hewlett-Packard HP LaserJet 1100

    Under 2.4.10 is looks like this:

    ...
    parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
    parport0: irq 7 detected
    ...

