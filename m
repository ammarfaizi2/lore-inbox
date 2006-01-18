Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932576AbWARW4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576AbWARW4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWARW4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:56:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932576AbWARW4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:56:37 -0500
Date: Wed, 18 Jan 2006 14:56:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Wireless issues (was Re: 2.6.16-rc1-mm1
Message-Id: <20060118145619.4b5c7a3a.akpm@osdl.org>
In-Reply-To: <200601182229.k0IMTJ56003467@turing-police.cc.vt.edu>
References: <20060118005053.118f1abc.akpm@osdl.org>
	<200601182229.k0IMTJ56003467@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Wed, 18 Jan 2006 00:50:53 PST, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm1/
> > 
> 
> My laptop has a Dell TrueMobile 1150 wireless card, which fell over using rc1-mm1.
>
> /sbin/pccardctl ident:
> 
> Socket 2:
>   product info: "Dell", "TrueMobile 1150 Series PC Card", "Version 01.01", ""
>   manfid: 0x0156, 0x0002
>   function: 6 (network)
> 
> Found in 2.6.16-rc1-mm1 dmesg:
> 
> orinoco 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> orinoco_cs 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> orinoco_cs: GetNextTuple(): No matching CIS configuration.  Maybe you need the ignore_cis_vcc=1 parameter.
> 2.0: GetFirstTuple: No more items
> orinoco_cs: GetNextTuple(): No matching CIS configuration.  Maybe you need the ignore_cis_vcc=1 parameter.
> 2.0: GetFirstTuple: No more items
> 
> and a non-functioning wireless card.
> 
> A 2.6.15 dmesg says:
> 
> orinoco 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> orinoco_cs 0.15rc3 (David Gibson <hermes@gibson.dropbear.id.au>, Pavel Roskin <proski@gnu.org>, et al)
> eth3: Hardware identity 0005:0004:0005:0000
> eth3: Station identity  001f:0001:0008:000a
> eth3: Firmware determined as Lucent/Agere 8.10
> eth3: Ad-hoc demo mode supported
> eth3: IEEE standard IBSS ad-hoc mode supported
> eth3: WEP supported, 104-bit key
> eth3: MAC address 00:02:2D:5C:11:48
> eth3: Station name "HERMES I"
> eth3: ready
> eth3: index 0x01: Vcc 3.3, irq 11, io 0xe100-0xe13f

There are orinoco changes in git-pcmcia.patch.  Could you try reverting
add-support-for-possio-gcc-aka-pcmcia-siemens-mc45.patch and then
git-pcmcia.patch?

> I haven't tried adding ignore_cis_vcc to the boot yet, I'm on my way out the door...

That shouldn't be necessary.
