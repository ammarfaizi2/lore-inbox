Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUERNbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUERNbV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 09:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUERNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 09:31:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:58041 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261981AbUERNbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 09:31:18 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Daniele Venzano <webvenza@libero.it>
Subject: Re: [PATCH] Sis900 bug fixes 0/4
Date: Tue, 18 May 2004 15:39:32 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040518120237.GC23565@picchio.gall.it>
In-Reply-To: <20040518120237.GC23565@picchio.gall.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405181539.32595.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 May 2004 14:02, Daniele Venzano wrote:
> I have prepared 4 patches that fix various issues with the sis900 driver
> in Linux 2.6.6, two of them had some discussion on lkml. The entire
> patchset has been tested by me, but patches 2 and 3 require testing from
> the people who reported the bugs (they are CCed).
>
> Patches 2,3,4 are incremental and need to be applied in that order.
>
> Patch summary:
> 1. change of maintainership for the sis900 driver
> 2. Add new ISA bridge PCI ID
> 3. Fix PHY transceiver detection code to fall back to known PHY and not
>    to the last detected.
> 4. Small cleanup and spelling fixes of sis900.h (much more needed, also
>    in sis900.c, will go through trivial).
>
> Any comment is highly appreciated.

I applied all 4 patches, but the wrong PHY transceiver is used now again.
Here is the dmesg output:

sis900.c: v1.08.07 11/02/2003
eth0: Unknown PHY transceiver found at address 0.
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Unknown PHY transceiver found at address 2.
eth0: Unknown PHY transceiver found at address 3.
eth0: Unknown PHY transceiver found at address 4.
eth0: Unknown PHY transceiver found at address 5.
eth0: Unknown PHY transceiver found at address 6.
eth0: Unknown PHY transceiver found at address 7.
eth0: Unknown PHY transceiver found at address 8.
eth0: Unknown PHY transceiver found at address 9.
eth0: Unknown PHY transceiver found at address 10.
eth0: Unknown PHY transceiver found at address 11.
eth0: Unknown PHY transceiver found at address 12.
eth0: Unknown PHY transceiver found at address 13.
eth0: Unknown PHY transceiver found at address 14.
eth0: Unknown PHY transceiver found at address 15.
eth0: Unknown PHY transceiver found at address 16.
eth0: Unknown PHY transceiver found at address 17.
eth0: Unknown PHY transceiver found at address 18.
eth0: Unknown PHY transceiver found at address 19.
eth0: Unknown PHY transceiver found at address 20.
eth0: Unknown PHY transceiver found at address 21.
eth0: Unknown PHY transceiver found at address 22.
eth0: Unknown PHY transceiver found at address 23.
eth0: Unknown PHY transceiver found at address 24.
eth0: Unknown PHY transceiver found at address 25.
eth0: Unknown PHY transceiver found at address 26.
eth0: Unknown PHY transceiver found at address 27.
eth0: Unknown PHY transceiver found at address 28.
eth0: Unknown PHY transceiver found at address 29.
eth0: Unknown PHY transceiver found at address 30.
eth0: Unknown PHY transceiver found at address 31.
eth0: Using transceiver found at address 31 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:8f:a9:ac.

greets,
dominik
