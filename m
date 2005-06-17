Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVFQNQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVFQNQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVFQNQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:16:26 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:59047 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261956AbVFQNQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:16:22 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM
	(was: Re: [ACPI] Resume from Suspend to RAM))
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <877jgw9a9c.fsf@www.codersbase.com>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <87ll5diemh.fsf@www.codersbase.com> <1118738841.6648.514.camel@tyrosine>
	 <877jgw9a9c.fsf@www.codersbase.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 14:16:03 +0100
Message-Id: <1119014163.12492.178.camel@elrond.flymine.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-14 at 09:24 -0700, dagit@codersbase.com wrote:
> Sure thing, (a) is called lspci-coldboot.txt and the other is
> lspci-warmboot.txt.  I've attached them so that you can see the whole
> thing, it doesn't look very helpful to me and the diff was even more
> cryptic, so good luck ;)

Ok, this is probably a long shot, but try:

setpci -s 00:00.0 67.b=11
setpci -s 00:00.0 68.b=4f
setpci -s 00:00.0 6d.b=47
setpci -s 00:00.0 9a.b=0a
setpci -s 00:00.0 9b.b=1d

after a cold boot, and then see if that changes the behaviour. My
suspicion is that Windows enables some northbridge features that affect
the behaviour of the system in suspend. Working out /what/ would be much
easier with datasheets, but ATI and VIA don't seem willing to provide
them (if anyone could provide me with northbridge PCI configuration
register specs for any non-Intel chipsets, that would be astonishingly
helpful)

-- 
Matthew Garrett | mjg59@srcf.ucam.org

