Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965871AbWKEMlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965871AbWKEMlO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 07:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965872AbWKEMlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 07:41:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965871AbWKEMlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 07:41:13 -0500
Subject: Re: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: conke.hu@amd.com, akpm@osdl.org
Cc: Luugi Marsan <luugi.marsan@amd.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1162729080.8525.49.camel@localhost.localdomain>
References: <20061103185420.B3FA6CBD48@localhost.localdomain>
	 <1162582216.12810.40.camel@localhost.localdomain>
	 <1162729080.8525.49.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 12:45:26 +0000
Message-Id: <1162730726.31873.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-11-05 am 20:17 +0800, ysgrifennodd Conke Hu:
>     1. The SATA configuration option "Legacy IDE mode" (as well as
> Native IDE mode) in SB600 BIOS is ONLY for old OS, and it is not useful
> any longer for new Linux kernels.

Some users choose to use old drivers for the feeling of security and
reduction of change. Remember there are users out there who have to go
through a formal verification process to switch the driver they use.

>     3. "This should only be done if AHCI is configured into the kernel,
> so wants a #ifdef check adding".
>     Alan, this fix should always be done whether AHCI is configured into
> kernel or not, even when AHCI is not configured at all. Because:
>     a). Without it, the SB600 SATA controller will appear as an IDE,
> which may misguide user to try to load legacy IDE driver (or other IDE

This is not neccessarily misguided. They may want to do this.

>     b). We have a RAID driver (close source) for SB600 SATA 

Thats your problem. Some day the lawyers can find out just how legal
that is.

You are right that most users will want to use the AHCI layer and that
if AHCI is compiled in then we should switch to AHCI. In the case the
kernel has no AHCI support compiled in the legacy driver support should
continue to work for it. This is how other vendors products such as
Jmicron are handled.

NAK reasserted.

Alan

