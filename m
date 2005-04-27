Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVD0Ce7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVD0Ce7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 22:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVD0Ce7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 22:34:59 -0400
Received: from fmr20.intel.com ([134.134.136.19]:33246 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261891AbVD0Ce5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 22:34:57 -0400
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: giskard <giskard@autistici.org>
Subject: Re: PROBLEM: error on handling I/O ports
Date: Wed, 27 Apr 2005 10:34:50 +0800
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20050425160936.0cb0d94e@localhost.localdomain>
In-Reply-To: <20050425160936.0cb0d94e@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200504271034.50045.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you just try acpi=off ?

On Monday 25 April 2005 22:09, giskard wrote:
> hi all,
>
> The 2.6.* kernel doesn't seems to handle properly the I/O ports for
> devices.
>
> I bought a toshiba satellite a80-111 and with 2.4 series all devices
> work good, with 2.6 series i get some errors:
>
> - the 2.4 kernel uses ide-generic (with sata support) for use the
>   hd, with 2.6 i need libata SATA support because i get this error
>
>   ide0: I/O resource 0x1F0-0x1F7 not free.
>   ide0: ports already in use, skipping probe
>
> - i have a 0000:06:04.0 CardBus bridge: Texas Instruments Texas
>   Instruments PCIxx21/ x515 Cardbus Controller
>
>   i can get it work with the 2.4 series with no problem (yenta
>   socket), the  2.6 series uses also yenta sockets but when i start
>   pcmcia service (/ etc/ init.d/pcmcia start) the kernel freezes when it
>   checks the i/o ports.
>
>
> mrspurr:/usr/src/linux# uname -a
> Linux mrspurr 2.6.11.7 #12 Mon Apr 18 01:51:04 CEST 2005 i686 GNU/Linux
>
> i attached lspci -vvv log, iomem log, ioports log, cpuinfo log
>
> thank you in advance
