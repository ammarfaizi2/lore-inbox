Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbUJ0TJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUJ0TJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUJ0TIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:08:41 -0400
Received: from alog0319.analogic.com ([208.224.222.95]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262597AbUJ0THe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:07:34 -0400
Date: Wed, 27 Oct 2004 15:04:22 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Daniel Phillips <phillips@istop.com>
cc: Timothy Miller <miller@techsource.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some discussion points open source friendly graphics [was:
 HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?]
In-Reply-To: <200410271423.33380.phillips@istop.com>
Message-ID: <Pine.LNX.4.61.0410271459130.4669@chaos.analogic.com>
References: <417D21C8.30709@techsource.com> <417D6365.3020609@pobox.com>
 <417D8218.9080700@techsource.com> <200410271423.33380.phillips@istop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Daniel Phillips wrote:

> On Monday 25 October 2004 18:45, Timothy Miller wrote:
>> My intention is to include a bit of logic in the FPGA which can be used
>> to reprogram the prom.  You would then cycle power to get the FPGA to
>> load the new code.
>
> Power cycle the whole machine, or software-reset the card?
>
> Regards,
>
> Daniel

The FPGA requires a physical reset-pin toggle to load new
bits into the gate-array. This could be software-toggled,
but that would require at least one external gate. This
is because the power-reset needs to reset the chip before
its bits are loaded plus some pin, after loading, needs to
be an output to its reset pin also. Therefore, you need
the external gate that is always present.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached and reviewed by John Ashcroft.
                  98.36% of all statistics are fiction.
