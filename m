Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287337AbSAXLTo>; Thu, 24 Jan 2002 06:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSAXLTY>; Thu, 24 Jan 2002 06:19:24 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:57732 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S287337AbSAXLTT> convert rfc822-to-8bit; Thu, 24 Jan 2002 06:19:19 -0500
Date: Thu, 24 Jan 2002 12:19:17 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Norbert Preining <preining@logic.at>
cc: linux-kernel@vger.kernel.org, Daniel Nofftz <nofftz@castor.uni-trier.de>
Subject: Re: amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020124094048.A17305@alpha.logic.tuwien.ac.at>
Message-ID: <Pine.LNX.4.40.0201241212250.7304-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Norbert Preining wrote:

> Hi Daniel!
>
> You wrote:
> > 2. enable generel-setup -> acpi , acpi-bus-maager , prozessor
> >    in the kernel config
>
> Why is it necessary to activate acpi which makes apm not working,
> and therefor poweroff etc. acpi is long from working/stable and
> the support for various actions too are missing.
>
> >From the patch I do not see why it is specific to acpi?
>
> Best wishes

hi norbert!

ok ... i  tested it:
patch activted:
apm activated -> prozessor idle calls : 42°C when idle
acpi activated -> prozessor c1/c2 states: 35°C when idle

under load:
apm activated -> 47°C kernel compiling after 2 min
acpi activated -> 43°C kernel compiling after 2 min

(kernel compiling only lasts about 3 min ... so no larger load intervalls
are avaible at the moment ... )

so ... you could use apm ... but acpi proofs to be better in power saveing
with the "disconnectenable when STPGNT detected" bit set ...
maybe apm is not working at all .. .cause at the moment i see that the
temperature does not drop at all after finishing the kernel ... it looks
like that the 42°C only where cause it was fresh rebooted from the acpi
power saving mode

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

