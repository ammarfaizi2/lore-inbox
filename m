Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313109AbSC1JEu>; Thu, 28 Mar 2002 04:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313110AbSC1JEj>; Thu, 28 Mar 2002 04:04:39 -0500
Received: from [195.63.194.11] ([195.63.194.11]:2827 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S313109AbSC1JEZ>;
	Thu, 28 Mar 2002 04:04:25 -0500
Message-ID: <3CA2DBFF.70509@evision-ventures.com>
Date: Thu, 28 Mar 2002 10:01:51 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, andersen@codepoet.org,
        Jos Hulzink <josh@stack.nl>, jw schultz <jw@pegasys.ws>,
        linux-kernel@vger.kernel.org
Subject: Re: DE and hot-swap disk caddies
In-Reply-To: <Pine.LNX.4.10.10203280012130.6661-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Open collector ~= a Tri-State or a float.

TTL logics based on bipolar diffusion transistors?
Certainly *not*. We are in CMOS land here where
the term open collector even doesn't apply at all.

Only the DASP (master slave selection pin) is OC and thus
most propably implemented by a bipolar transitor, which seems
logical, since this line has to have a big fan-out current to
basically enable quite a few gates.

> It does exist for the "DATA" lines, and those are not setup to float until
> there is a referrence ground to set the buffer on the ATA drive.
> ATAPI (best known by me is HP-Colorado 8GB tape) will suck power off the
> ribbon if there is no line voltage applied to the Molex connector.

This is most possibly the hard wired resistor bridge used for termination
which you see "sucking the power".

> I hate to say of you are core developing on a laptop, you are not playing
> w/ native hardware.  Laptops to special things, period.

Not at all. (BTW. I don't do my main developement on a notebook. Never
said that.)

> ATA does not goe the distance because they did not put line drivers of any
> strength, the the $5.00 difference in the controllor on the bottom of the

Did I say it was cheap CMOS and not TTL? Do you still wonder
why the output drivers are not able to provide strong output currents?

> drive.  Also I have cables which are 3 feet and run in mode 5 or Ultra100,
> but you can be sure that it is a special HOST to provide the push and
> power to make the distance.  It has 80c headers on the HOST side but 40c
> IDC's on the device side.

It is most likely that the special "host" provides only special
partial termination. And the ribbons you use are most propably of
low resistance (possibly silver plated copper cores).
Otherwise the signals from the disks wouldn't be able to travel back.

