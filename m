Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264696AbVBDSTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbVBDSTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbVBDSQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 13:16:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32212 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265648AbVBDSK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 13:10:58 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Fri, 4 Feb 2005 10:10:12 -0800
User-Agent: KMail/1.7.2
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <20050204163019.GC1290@elf.ucw.cz> <9e4733910502040931955f5a6@mail.gmail.com>
In-Reply-To: <9e4733910502040931955f5a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041010.13220.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 4, 2005 9:31 am, Jon Smirl wrote:
> For non-x86 systems put an emu version on initramfs. My statically
> linked against klibc x86 reset app is about 15K. The emu version is
> significantly bigger but there is no way to avoid it if you are using
> x86 hardware in a non-x86 box.

Jon does your emulator sit on top of the new legacy I/O and memory APIs?  I 
added them for this very reason, though atm only ia64 supports them.  There's 
documentation in Documentation/filesystems/sysfs-pci.txt if you want to take 
a look.  On kernels that support it, sysfs can be a one stop shop for all 
your gfx programming needs, since it provides access to the rom, PCI 
resources (i.e. MMIO ranges, fb memory, etc.) and legacy I/O ports and 
memory.

Jesse
