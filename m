Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbWF0GUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWF0GUl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030658AbWF0GUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:20:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030667AbWF0GUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:20:40 -0400
Date: Mon, 26 Jun 2006 23:20:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Edgar Hucek <hostmaster@ed-soft.at>
cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH 1/1] Fix boot on efi 32 bit Machines [try #4]
In-Reply-To: <44A0CCEA.7030309@ed-soft.at>
Message-ID: <Pine.LNX.4.64.0606262318341.3927@g5.osdl.org>
References: <44A04F5F.8030405@ed-soft.at> <Pine.LNX.4.64.0606261430430.3927@g5.osdl.org>
 <44A0CCEA.7030309@ed-soft.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Edgar Hucek wrote:
>
> So what is your suggestion to get the working funktionality
> from kernel 2.6.16 back ? 2.6.17 have broken it.

I'd really suggest just filling in the e820 table from the EFI information 
early at boot.

(Even better would be for the EFI bootloader on x86 to just fill things in 
_as_if_ it was filling in e820 data, but that's outside of the kernel, so 
if you want the _kernel_ to be able to handle native EFI data, do it by 
just translating it once into e820 mode, and you're done).

The translation from EFI to e820 format should be very straightforward 
indeed. I think it's pretty much the same thing with different naming.

		Linus
