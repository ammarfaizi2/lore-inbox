Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUEIC4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUEIC4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 22:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEIC4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 22:56:25 -0400
Received: from fmr10.intel.com ([192.55.52.30]:62418 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S264260AbUEIC4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 22:56:19 -0400
Subject: Re: hdc: lost interrupt ide-cd: cmd 0x3 timed out ...
From: Len Brown <len.brown@intel.com>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Alex Riesen <fork0@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FAE21@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FAE21@hdsmsx403.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1084071367.2326.62.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 May 2004 22:56:07 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 15:41, Bob Gill wrote:
> OK, great!  Adding acpi=noirq to the kernel line made the lost
> interrupt problem go away.

Bob, Alex,
(or anybody else with a SIS-961 that now requires acpi=noirq),

I need some info to find out why your system recently broke.

Please open a bug here and attach the info,
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
or just e-mail it to me and I'll open a bug for you.

Need the complete dmesg and /proc/interrupt from the most recent ACPI
enabled kernel that worked properly -- I guess -bk6 worked okay?

Any chance you can boot with "debug" and capture the console messages
from the failure?  If no, then the complete dmesg of the latest kernel
with "acpi=noirq" is the next best thing.

output from lspci -vv

output acpidmp available in /usr/sbin/, or in pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

thanks,
-Len

ps. would also be good to verify you're running an up-to-date BIOS.

pps. taking a wild guess, can you try backing out this patch?

#   ACPI: No IRQ known ... - using IRQ 255 (Bjarni Rúnar Einarsson)
#   http://bugzilla.kernel.org/show_bug.cgi?id=2148

http://linux.bkbits.net:8080/linux-2.5/gnupatch@408a06a6JHD43KPCLW3tDIYGowoxvg


