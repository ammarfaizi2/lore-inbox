Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267772AbUJONac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267772AbUJONac (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUJONab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:30:31 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:3791 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267772AbUJON3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:29:36 -0400
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       "mobil@wodkahexe.de" <mobil@wodkahexe.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
	 <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
	 <16750.23132.41441.649851@alkaid.it.uu.se>
	 <Pine.LNX.4.58L.0410142225160.25607@blysk.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097843198.9855.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 15 Oct 2004 13:26:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-10-14 at 23:27, Maciej W. Rozycki wrote:
> +			printk("Not enabling local APIC "
> +			       "because of frequent BIOS bugs\n");
> +			printk("You can enable it with \"lapic\"\n");
> +			return -1;
> +		}

Looks completely wrong to me. The BIOS disabled it or left it disabled
because they chose not to support it. We enabled it and then relied on
bios functionality.

Our bug

