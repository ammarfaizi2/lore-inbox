Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVCUWkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVCUWkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 17:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVCUWgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:36:18 -0500
Received: from alpha.polcom.net ([217.79.151.115]:33770 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S262097AbVCUWer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:34:47 -0500
Date: Mon, 21 Mar 2005 23:36:37 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: len.brown@intel.com, duncan.sands@free.fr,
       linux-usb-users@lists.sourceforge.net, gregkh@suse.de,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.11 (stable and -rc) ACPI breaks USB
In-Reply-To: <20050321142056.7609d615.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0503212329190.6194@alpha.polcom.net>
References: <Pine.LNX.4.62.0503030053120.6789@alpha.polcom.net>
 <20050321142056.7609d615.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Andrew Morton wrote:

> Grzegorz Kulewski <kangur@polcom.net> wrote:
>>
>> Hi,
>>
>> I just installed 2.6.11 and I was hit by the same bug (or feature?) I
>> found in -rcs. Basically my USB will work only if acpi=off was passed to
>> the kernel. It looks like without acpi=off it will assign IRQ 10 and with
>> acpi=off it will assign IRQ9. It worked at least with 2.6.9. I do not know
>> if the USB is completly broken but at least my speedtouch modem will not
>> work (the red led will be on for some time then completly black).
>>
>
> I didn't really follow all the ins and outs on this one.  Will it end up
> being adequately resolved for 2.6.12?

It was identified (by Bjorn) to be some ACPI VIA PCI IRQ routing quirk 
logic change (as far as I understand it). Unfortunatelly it is not good 
for my board (AMD 761 North and VIA 686B South). Bjorn (huge thanks to 
him) produced testing patch that fixed it for me. Further patches were 
presented and discussed in the other thread. The newest one is waiting for 
final testing from me (in couple of minutes probably). I will CC you on my 
reply (if you are not already). As of what to do next with this patch (if 
it still works) Bjorn and others should reply.


> Thanks.

Thanks for interest,

Grzegorz Kulewski

