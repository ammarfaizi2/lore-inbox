Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbTIEVqi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbTIEVqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:46:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14731 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265435AbTIEVpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:45:53 -0400
Message-ID: <3F590400.7050600@pobox.com>
Date: Fri, 05 Sep 2003 17:45:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Richard A Nelson <kenpocowboy@bellsouth.net>
CC: Patrick Mochel <mochel@osdl.org>, Rob Landley <rob@landley.net>,
       Pavel Machek <pavel@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
References: <200309050158.36447.rob@landley.net> <Pine.LNX.4.44.0309051044470.17174-100000@cherise> <20030905180248.GB29353@gtf.org> <Pine.LNX.4.56.0309051548400.18554@onpx40.onqynaqf.bet>
In-Reply-To: <Pine.LNX.4.56.0309051548400.18554@onpx40.onqynaqf.bet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard A Nelson wrote:
> On Fri, 5 Sep 2003, Jeff Garzik wrote:
> 
> 
>>Note that a lot of ThinkPads out in the field need a BIOS update
>>before their ACPI is working.  (I know this because IBM was quite
>>helpful and proactive in addressing their Linux-related ACPI BIOS
>>issues)
> 
> 
> And even that isn't always enough :(
> 
> I have a TP30, 2366-51U with the latest BIOS:
>                 Version: 1IET67WW (2.06 )
>                 Release: 07/17/2003
>                 Processor Manufacturer: GenuineIntel
>                 Processor Version: Pentium(R) 4
> BIOS32 Service Directory present.
>         Calling Interface Address: 0x000FD7E0
> ACPI 2.0 present.
>         OEM ID: IBM
> RSD table at 0x0FF63195.
> PNP 1.0 present.
>         Event Notification: Polling
>         Event Notification Flag Address: 0x000004B4
>         Real Mode Code Address: F000:9D36
>         Real Mode Data Address: 0040:0000
>         Protected Mode Code Address: 0x000F9D54
>         Protected Mode Data Address: 0x00000400
> PCI Interrupt Routing 1.0 present.
>         Table Size: 256 bytes
>         Router ID: 00:1f.0
>         Exclusive IRQs: None
>         Compatible Router: 8086:122e
> 
> Up through 2.05, ACPI crashed the kernel during boot(2.4 and 2.6) -
> I posted here about that...  I'm going to try this weekend with
> the just flashed 2.06 - even though the changelog doesn't indicate
> anything changed wrt ACPI.
> 
> The problem was, iirc, was scanning one of the tables - I can't find
> the message now :(


If you are up for a little debugging and comfortable with building your 
own kernels, then please enable the relaxed-aml-checking and debug 
options in the ACPI kernel config.  Those, and dmidecode output, will 
provide useful info to the ACPI folks.

	Jeff



