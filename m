Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVFUL65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVFUL65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFULzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:55:38 -0400
Received: from cantor2.suse.de ([195.135.220.15]:43432 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261300AbVFULsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:48:41 -0400
From: Andreas Schwab <schwab@suse.de>
To: k8 s <uint32@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct iphdr in include/linux/ip.h (probably bug in headerfile)
References: <699a19ea05062100157c17c09c@mail.gmail.com>
X-Yow: Yes, Private DOBERMAN!!
Date: Tue, 21 Jun 2005 13:48:37 +0200
In-Reply-To: <699a19ea05062100157c17c09c@mail.gmail.com> (uint32@gmail.com's
	message of "Tue, 21 Jun 2005 12:45:20 +0530")
Message-ID: <je3brchqwa.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

k8 s <uint32@gmail.com> writes:

> Hello,
>
> The following definition in linux/include/ip.h is creating problems.
>
> How does Endianness affect BIT ORDER 
> IT affetc only  BYTE ORDER

Bit order and byte order are independent properties of the architecture.
That's why they are configured with different macros.

> ------------------------------------------------------------------------
> struct iphdr {
> #if defined(__LITTLE_ENDIAN_BITFIELD)
>         __u8    ihl:4,
>                 version:4;
> #elif defined (__BIG_ENDIAN_BITFIELD)
>         __u8    version:4,
>                 ihl:4;
> --------------------------------------------------------------------------
> Here I have a network device which works on both little endian and big
> endian machines.
> I found out that the driver of the device was saying unrecognizable
> packet when i assign

The you probably didn't define the right macro of the ones referenced
above.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
