Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265577AbSJSJxk>; Sat, 19 Oct 2002 05:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265580AbSJSJxj>; Sat, 19 Oct 2002 05:53:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40970 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265577AbSJSJxj>; Sat, 19 Oct 2002 05:53:39 -0400
Date: Sat, 19 Oct 2002 10:59:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: jt@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 orinoco_cs with Lucent WaveLAN "bronze"
Message-ID: <20021019105938.A14830@flint.arm.linux.org.uk>
References: <200210190922.g9J9M4p15225@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210190922.g9J9M4p15225@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Sat, Oct 19, 2002 at 02:14:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 02:14:57PM +0000, Denis Vlasenko wrote:
> Today I played with wireless LAN euqipment for the first time.
> I have ISA-to-PCMCIA converter and a Lucent (IEEE) PCMCIA card.
> I set up everything as directed by HOWTOs. I do:

Yes, I also noticed many problems with the current orinoco_cs driver.
I've reported them to David, but had very little response thus far.
Basically, iwconfig ethx essid foo appears to crash the cards firmware
(I get really interesting series of words in the chips registers giving
a nice ASCII string.)

I did find that if I took the wvlan_cs driver from a Red Hat kernel and
drop it into 2.5, it works (as far as I can tell) quite nicely.

Unfortunately, I haven't been able to do any further investigation of
this; I'm not too bothered because wvlan_cs gets me working.

(My card is a Lucent WaveLAN Silver)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

