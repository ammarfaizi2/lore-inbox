Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUDEXMv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUDEXMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:12:51 -0400
Received: from [202.65.75.150] ([202.65.75.150]:41633 "EHLO
	pythia.bakeyournoodle.com") by vger.kernel.org with ESMTP
	id S263475AbUDEXME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:12:04 -0400
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Tue, 6 Apr 2004 07:03:51 +0800
To: "Calin A. Culianu" <calin@ajvar.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: Stupid question re: register_cdrom()
Message-ID: <20040405230351.GR3445@bakeyournoodle.com>
Mail-Followup-To: "Calin A. Culianu" <calin@ajvar.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0404051649510.16268-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0404051649510.16268-100000@rtlab.med.cornell.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 04:53:16PM -0400, Calin A. Culianu wrote:
> 
> Let's say I was coding a cdrom emulator in software for kernel 2.4.  I
> am unclear about register_cdrom().  Does register_cdrom() in
> cdrom.c take care of telling the kernel that my kdev_t major/minor
> combination in fact leads to a real driver?  Or do I need to take care of
> that outside of regsiter_cdrom()?
> 
> If not.. how do I tell the kernel data structures that my driver's major
> number does in fact point to a cdrom driver.  Basically, I want my
> driver's major number to show up in /proc/devices..
> 
> This might be a stupid question, but I am not a linux kernel expert...

Neither am I, therefore I hope you get a reply from someone else
refuting or acknowledging my claims.


I looks to me that the code that does the actual registration of the
driver is in drivers/ide/ide-cd.c NOT cdrom.c.  Specifically
ide_cdrom_attach().  Said function eventually calls the register_cdrom()
you ask about.

For writing a cdrom emulator  You may want to look more closely at the
non-IDE/SCSI devices as they seem to register their driver data
themselves  I had a quick read of aztcd.c, I think between cdrom.c and
aztcd.c you should be able to piece together what you want.

Also Try reading http://www.xml.com/ldd/chapter/book/ for details on 2.4
drivers

Yours Tony

        linux.conf.au       http://lca2005.linux.org.au/
	Apr 18-23 2005      The Australian Linux Technical Conference!

