Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVBTKTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVBTKTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVBTKTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:19:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47884 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261771AbVBTKTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:19:06 -0500
Date: Sun, 20 Feb 2005 10:19:02 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Message-ID: <20050220101902.B9509@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
	linux-kernel@vger.kernel.org
References: <20050220092208.GA12738@hardeman.nu> <20050220092659.A9509@flint.arm.linux.org.uk> <20050220095211.GB12738@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050220095211.GB12738@hardeman.nu>; from david@2gen.com on Sun, Feb 20, 2005 at 10:52:12AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 10:52:12AM +0100, David Härdeman wrote:
> e820 map:
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
>  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000000f6f0000 (usable)
>  BIOS-e820: 000000000f6f0000 - 000000000f700000 (reserved)
>  BIOS-e820: 000000000f700000 - 000000003f6f0000 (usable)
>  BIOS-e820: 000000003f6f0000 - 000000003f6f8000 (ACPI data)
>  BIOS-e820: 000000003f6f8000 - 000000003f6fa000 (ACPI NVS)
>  BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
> 118MB HIGHMEM available.
> 896MB LOWMEM available.
> 
> Is the hole between 0x36f6fa000 and 0x3f700000?

Looks like it.

> And what would be the proper way of fixing it (assuming that IBM won't 
> issue a fixed BIOS)?

Try passing:

	reserve=0x3f6fa000,0x6000

to the kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
