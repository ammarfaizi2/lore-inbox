Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWH2QR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWH2QR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 12:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWH2QR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 12:17:28 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:5514 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965055AbWH2QR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 12:17:27 -0400
Date: Tue, 29 Aug 2006 17:17:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
       linuxppc-embedded@ozlabs.org, paulkf@microgate.com,
       takata@linux-m32r.org, linux-kernel@vger.kernel.org
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions
Message-ID: <20060829161748.GF29289@linux-mips.org>
References: <20060828085244.GA13544@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 09:52:44AM +0100, Russell King wrote:

> asm/serial.h is supposed to contain the definitions for the architecture
> specific 8250 ports for the 8250 driver.  It may also define BASE_BAUD,
> but this is the base baud for the architecture specific ports _only_.
> 
> Therefore, nothing other than the 8250 driver should be including this
> header file.  In order to move towards this goal, here is a patch which
> removes some of the more obvious incorrect includes of the file.
> 
> MIPS and PPC has rather a lot of stuff in asm/serial.h, some of it looks
> related to non-8250 ports.  Hence, it's not trivial to conclude that
> these includes are indeed unnecessary, so can mips and ppc people please
> test this patch carefully.

The MIPS bits were just unused leftovers from the days when the arch
code did did register serials & consoles.  So for the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
