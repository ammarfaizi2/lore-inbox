Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbTAXVGM>; Fri, 24 Jan 2003 16:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbTAXVGM>; Fri, 24 Jan 2003 16:06:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S265681AbTAXVGJ>;
	Fri, 24 Jan 2003 16:06:09 -0500
Date: Fri, 24 Jan 2003 16:15:23 -0500
From: Christopher Faylor <cgf@redhat.com>
To: lost@l-w.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <20030124211523.GA14229@redhat.com>
References: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us> <Pine.LNX.4.51.0301241337080.28717@potnoodle.l-w.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0301241337080.28717@potnoodle.l-w.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 01:46:10PM -0700, lost@l-w.net wrote:
>On Fri, 24 Jan 2003, David C Niemi wrote:
>
>> I have been experiencing some baffling SSH client hangs under 2.5.59 (and
>> 55) in which the session totally hangs up after I have typed (typically)
>> 10-100 characters.  Right before it hangs permanently, a character is
>> echo'd back to the screen several seconds late.  Interestingly, data due
>> back for my client which is initiated by the server side does make it, I
>> just can't type anything further.
>
><snip>
>
>> Neither "ifconfig" nor dmesg show *any* errors whatsoever.
>>
>> Anyone else seeing SSH client hangs to nonlocal hosts under 2.5.59?
>
>I'm seeing the same problem with a D-Link NIC (8139too driver). Exact same
>symptoms - a delayed echo followed by no further echos. Checking netstat
>shows an output queue for the socket but it never transmits anything.
>Messages echoed by the remote server also make it through the connection.

I hate "me toos" but maybe this will provide some useful data.

I'm seeing the same thing with a 3c59x driver.  I couldn't reproduce the
problem with a tulip driver when I connect my laptop directly to my
cable modem.  The problem only occurs when going through the laptop
(which acts as a firewall, running netfilter) to a remote site, in my
case the site is sources.redhat.com.

cgf
