Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUENQED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUENQED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUENQED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:04:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57008 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261638AbUENQCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:02:30 -0400
Message-ID: <40A4ED87.20608@pobox.com>
Date: Fri, 14 May 2004 12:02:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>,
       Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: port disabled.  ignoring.
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be> <20040514150900.GA19315@lists.us.dell.com>
In-Reply-To: <20040514150900.GA19315@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Fri, May 14, 2004 at 03:11:00PM +0200, Geert Uytterhoeven wrote:
> 
>>I'm trying to install Linux on a SATA disk in a Dell PowerEdge 750, which has
>>an Intel 82875P chipset with an Intel 6300ESB SATA Storage Controller.
> 
> 
> [snip]
>  
> 
>>I looked at ata_piix.c, and apparently the driver decides whether a port is
>>disabled by checking a bit in PCI config space, so this looks like a BIOS setup
>>problem to me. But the BIOS has the first SATA port enabled (`AUTO', and it
>>does see a 80 GB disk there), while the PATA and second SATA ports are marked
>>`OFF'.
> 
> 
> Right.  At present you need to enable the second SATA  port in the
> BIOS.  Disabling it also disables the first port from being
> recognized by the driver.  It's a figment of the "compatability mode"
> that the PE750 runs in.  I believe Stuart Hayes sent Jeff a patch to
> address this, but I can't find it handy...


That _should_ have been fixed in the last update to ata_piix.  If you 
could get Stuart to re-test and re-submit that patch if necessary, that 
would be useful.

Geert, two things to try:
1) Try the latest kernel
2) Fiddle with BIOS settings until your PATA and SATA devices appear as 
_separate_ devices on the PCI bus.


