Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277353AbRKHR52>; Thu, 8 Nov 2001 12:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277143AbRKHR4H>; Thu, 8 Nov 2001 12:56:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:31249 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277094AbRKHRzq>; Thu, 8 Nov 2001 12:55:46 -0500
Message-ID: <3BEAC5E2.5A301DB@zip.com.au>
Date: Thu, 08 Nov 2001 09:50:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matt <madmatt@bits.bris.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: WOL stops working on halt
In-Reply-To: <Pine.LNX.4.21.0111080908260.20023-100000@bits.bris.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> 
> Hi list,
> 
> I have a 3c980 NIC plugged into an Abit KT7-RAID and connected together
> with a WOL cable. I can't seem to get WOL to work using the ether-wake
> utility if I power the box down with shutdown(8). The only way I can
> currently get WOL to work is if I reboot the box, then physically press
> the power button to turn it off.

As far as the driver is concerned, a shutdown and a reboot are identical,
so we need to look at external causes.  Presumably Linux APM or BIOS.
 
> I'm loading the 3c59x.o driver using the enable_wol option, but I'm not
> currently using ACPI. Looking through the 3c59x.c code, I notice it relies
> on the box being put into a certain ACPI state. Will the ACPI code do this
> on shutdown?

The driver has no dependency on the kernel's ACPI code.  It
uses a function called `acpi_set_WOL' for historical reasons.

Sorry - that wasn't a lot of help :(
