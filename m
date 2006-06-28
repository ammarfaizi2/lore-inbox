Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWF1WiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWF1WiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWF1WiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:38:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9176 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751629AbWF1WiL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:38:11 -0400
Message-ID: <44A304C1.2050304@zytor.com>
Date: Wed, 28 Jun 2006 15:37:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Edgar Hucek <hostmaster@ed-soft.at>, LKML <linux-kernel@vger.kernel.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org> <44A0CCEA.7030309@ed-soft.at> <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 27 Jun 2006, Edgar Hucek wrote:
>> So what is your suggestion to get the working funktionality
>> from kernel 2.6.16 back ? 2.6.17 have broken it.
> 
> I'd really suggest just filling in the e820 table from the EFI information 
> early at boot.
> 
> (Even better would be for the EFI bootloader on x86 to just fill things in 
> _as_if_ it was filling in e820 data, but that's outside of the kernel, so 
> if you want the _kernel_ to be able to handle native EFI data, do it by 
> just translating it once into e820 mode, and you're done).
> 
> The translation from EFI to e820 format should be very straightforward 
> indeed. I think it's pretty much the same thing with different naming.
> 

You probably don't want to put it in the bootloader.  The kernel is 
easier to upgrade than the bootloader, which is easier to upgrade than 
the firmware, so it makes more sense for the kernel to be as 
self-sufficient as is possible, or at least practical.

	-hpa

