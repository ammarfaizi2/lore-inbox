Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVBDN4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVBDN4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 08:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262920AbVBDNxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 08:53:30 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:8105 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261298AbVBDNwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 08:52:18 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       Pavel Machek <pavel@ucw.cz>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <420367CF.7060206@gmx.net>
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>	 <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com>  <420367CF.7060206@gmx.net>
Date: Fri, 04 Feb 2005 13:51:17 +0000
Message-Id: <1107525077.8575.32.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 13:17 +0100, Carl-Daniel Hailfinger wrote:
> Jon Smirl schrieb:
> > A starting place for a user space reset program:
> > ftp://ftp.scitechsoft.com/devel/obsolete/x86emu/x86emu-0.8.tar.gz
> > 
> > This thread talks about the VGA routing code:
> > http://lkml.org/lkml/2005/1/17/347
> 
> Thanks for the pointers! I'll have to compare it to our current
> userspace reset and vesa register restoring program
> http://www.srcf.ucam.org/~mjg59/vbetool/

I'm planning on getting x86emu support into vbetool in the near future,
mostly because AMD64 doesn't have vm86 support. It's worth noting that
attempting to re-POST many (most?) laptops will fail miserably - the
code simply isn't available after boot. Saving/restoring state with VBE
code tends to be more reliable, but there are some machines that need
POSTing.

In the long run, it's the sort of thing that needs a hardware database,
which effectively requires it to be in userspace.
-- 
Matthew Garrett | mjg59@srcf.ucam.org

