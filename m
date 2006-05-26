Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWEZHQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWEZHQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWEZHQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:16:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:6121 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751339AbWEZHQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:16:01 -0400
Date: Fri, 26 May 2006 09:15:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, Andreas Saur <saur@acmelabs.de>,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc4-mm3 - kernel panic
Message-ID: <20060526071518.GC1699@elf.ucw.cz>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E1@hdsmsx411.amr.corp.intel.com> <1148583675.3070.41.camel@whizzy> <20060525221222.GA1608@elf.ucw.cz> <20060525221744.GA1671@elf.ucw.cz> <1148601858.3070.62.camel@whizzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1148601858.3070.62.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 25-05-06 17:04:18, Kristen Accardi wrote:
> On Fri, 2006-05-26 at 00:17 +0200, Pavel Machek wrote:
> > On Pá 26-05-06 00:12:22, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > Does the panic go away with CONFIG_ACPI_DOCK=n?
> > > 
> > > > Can either Pavel or Andreas please try this little debugging patch and
> > > > send me the dmesg output?  Please enable the CONFIG_DEBUG_KERNEL option
> > > > in your .config as well so that I can get additional info.
> > > 
> > > Yep, you were right... this debugging patch helps.
> > 
> > ...and docking +/- works, but it does not look like PCI in docking
> > station is properly connected:
> > 
> 
> No, I would not expect PCI to work properly with the debug patch -
> basically all I did was prevent the oops and confirm that this is the
> issue, I did not actually solve the problem.
> 
> I need some way to prevent acpiphp from loading before dock is completed
> it's init.
> 
> I guess I will think about this some more.

Using different _init levels? Like putting dock at subsys_initcall()
while acpiphp at late_initcall()?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
