Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWJTJyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWJTJyx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 05:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWJTJyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 05:54:53 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:2904 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751704AbWJTJyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 05:54:52 -0400
Message-ID: <45389CE4.7050406@tls.msk.ru>
Date: Fri, 20 Oct 2006 13:54:44 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Mirko Lindner <mlindner@syskonnect.de>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 4/6] net: use bitrev8
References: <20061018164647.GD21820@localhost> <20061019133951.1d463173.akpm@osdl.org>
In-Reply-To: <20061019133951.1d463173.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 19 Oct 2006 01:46:47 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
>> Use bitrev8 for bmac, mace, macmace, macsonic, and skfp drivers.
>>
[]
>> ===================================================================
>> --- work-fault-inject.orig/drivers/net/Kconfig
>> +++ work-fault-inject/drivers/net/Kconfig
>> @@ -2500,6 +2500,7 @@ config DEFXX
>>  config SKFP
>>  	tristate "SysKonnect FDDI PCI support"
>>  	depends on FDDI && PCI
>> +	select BITREVERSE
>>  	---help---
>>  	  Say Y here if you have a SysKonnect FDDI PCI adapter.
>>  	  The following adapters are supported by this driver:
> 
[]
> But select is problematic and I do wonder whether it'd be simpler to just
> link the thing into vmlinux.

Why it's problematic?  Maintenance costs of various missing selects?
I don't want extra stuff in kernel (vmlinux) if it's not used.

/mjt
