Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264348AbUEMRzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbUEMRzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbUEMRzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:55:41 -0400
Received: from pop.gmx.net ([213.165.64.20]:40909 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264348AbUEMRz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:55:29 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Daniele Venzano <webvenza@libero.it>
Subject: Re: problem with sis900
Date: Thu, 13 May 2004 20:02:56 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1084300104.24569.8.camel@datacontrol> <200405120030.12883.dominik.karall@gmx.net> <20040513151759.GA27382@gateway.milesteg.arr>
In-Reply-To: <20040513151759.GA27382@gateway.milesteg.arr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132002.56402.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 May 2004 17:17, Daniele Venzano wrote:
> On Wed, May 12, 2004 at 12:30:12AM +0200, Dominik Karall wrote:
> [...]
>
> > nvidia: module license 'NVIDIA' taints kernel.
> > 0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336  Wed
> > Jan 14 18:29:26 PST 2004
>
> [...]
>
> Your kernel is tainted, but I'm willing to think that you can reproduce
> the problem without binary modules loaded. Please confirm this.

Yes, I'm using the kernel nv driver now.

>
> > Let me know if you need more infos!
>
> It seems that the driver is confused by the on chip informations it
> reads and detects some 'ghost' transceivers, then decides to use one of
> those, instead of taking the real one.
>
> The following patch is a guess in this direction, it should make the
> driver get the PHY at address 1, the one detected correctly for you.
> Obviously, if it works, I'll need to make the patch a bit more
> general before submission...

Sorry, but the patch does not help, same error messages in log, and can't 
change to full-duplex mode.

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
eth0: Using transceiver found at address 30 as default
eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:8f:a9:ac.
