Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbUENPMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbUENPMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 11:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUENPMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 11:12:43 -0400
Received: from lists.us.dell.com ([143.166.224.162]:36829 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261498AbUENPMe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 11:12:34 -0400
Date: Fri, 14 May 2004 10:09:00 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: port disabled.  ignoring.
Message-ID: <20040514150900.GA19315@lists.us.dell.com>
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 03:11:00PM +0200, Geert Uytterhoeven wrote:
> I'm trying to install Linux on a SATA disk in a Dell PowerEdge 750, which has
> an Intel 82875P chipset with an Intel 6300ESB SATA Storage Controller.

[snip]
 
> I looked at ata_piix.c, and apparently the driver decides whether a port is
> disabled by checking a bit in PCI config space, so this looks like a BIOS setup
> problem to me. But the BIOS has the first SATA port enabled (`AUTO', and it
> does see a 80 GB disk there), while the PATA and second SATA ports are marked
> `OFF'.

Right.  At present you need to enable the second SATA  port in the
BIOS.  Disabling it also disables the first port from being
recognized by the driver.  It's a figment of the "compatability mode"
that the PE750 runs in.  I believe Stuart Hayes sent Jeff a patch to
address this, but I can't find it handy...

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
