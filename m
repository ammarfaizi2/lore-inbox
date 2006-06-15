Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWFOHZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWFOHZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 03:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbWFOHZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 03:25:19 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:50589 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751238AbWFOHZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 03:25:18 -0400
Message-ID: <44910B54.8000408@cmu.edu>
Date: Thu, 15 Jun 2006 03:25:08 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: cdrom support with thinkpad x6 ultrabay
References: <4490E776.7080000@cmu.edu> <4490F4BC.1040300@goop.org>
In-Reply-To: <4490F4BC.1040300@goop.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeremy Fitzhardinge wrote:
> George Nychis wrote:
>> I am looking for support somewhere in the kernel for my thinkpad x6
>> ultrabay's cdrom drive.  Whenever I attach the ultrabay it picks up the
>> extra usb ports, seems to pick up the ethernet port, but it fails to
>> pick up anything about the dvd/cd-writer.  Nothing shows up in dmesg
>> about the drive at all... anyone know what I might need in the kernel?
>> I am using 2.6.17-rc6
> -mm has some support for the dock, but there isn't support for hot
> add/remove of the optical device yet.  I think that's waiting on some
> support in libata, but I'm not exactly sure what's needed.
> 
> At the moment, you either get the dock optical if you boot the machine
> in the dock, and you can never eject the dock, or you get no optical and
> eject works fine.
> 
>    J
> 

Thanks for the responses Jeremy and Randy.

I tried taking the acpi dock patch seperately out of the mm patchset by
applying this patch:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/broken-out/acpi-dock-driver.patch

it successfully is applied, and i notice that CONFIG_ACPI_DOCK needs to
be set, so I did a "make oldconfig" after applying the patch, expecting
it to ask me whether or not i wanted to support it... it didn't.  So
then I manually added "CONFIG_ACPI_DOCK=y" to the .config and built the
kernel, but dock.o is never built... what else do i need to do?

If i can't get hot swappable support yet, I might as well get what is
supported for now so I can atleast use it sometimes :)

Maybe this cry for help will spark someone to finish off the work on hot
swapping the optical drive.

Thanks!
George
