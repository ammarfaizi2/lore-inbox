Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVKVGH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVKVGH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 01:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbVKVGH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 01:07:28 -0500
Received: from [85.8.13.51] ([85.8.13.51]:45214 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932125AbVKVGH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 01:07:26 -0500
Message-ID: <4382B596.5080001@drzeus.cx>
Date: Tue, 22 Nov 2005 07:07:18 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.7-2.1.fc4.nr (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Secure Digital Host Controller PCI class
References: <4381B364.2020808@drzeus.cx> <20051121214733.GA17793@suse.de>
In-Reply-To: <20051121214733.GA17793@suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Mon, Nov 21, 2005 at 12:45:40PM +0100, Pierre Ossman wrote:
>  
>
>>I'm working on a driver for the Secure Digital Host Controller
>>interface. This is a generic interface, so it uses a PCI class for
>>identification instead of vendor/device ids.
>>
>>The class ID used is 0805 and the programming interface (correct term?)
>>indicates DMA capabilities. Greg, since you're the PCI maintainer,
>>perhaps you have the possibility of checking this ID?
>>    
>>
>
>What do you mean "checking this ID"?  Checking it with what?
>
>  
>

I figured you might have access to the official allocations from the PCI
SIG.

>>The standard also dictates a register at offset 0x40 in PCI space. This
>>is a one byte register detailing the number of slots on the controller
>>and the first BAR to use.
>>    
>>
>
>Do you have a pointer to the standard?
>
>  
>

The SDHC standard itself is a well guarded secret. We're basing this
work on the little information that is out there and reverse engineering
the Windows driver. The PCI registers are described in a spec. by Texas
Instruments though:

http://www-s.ti.com/sc/ds/pci6411.pdf

They only use three bits for each field (since their controller only has
three slots), but the Windows driver reads four so that is what I've put
in the patch.

Rgds
Pierre

