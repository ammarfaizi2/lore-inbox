Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263643AbVBECYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbVBECYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVBECYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:24:12 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:13232 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S266390AbVBECRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:17:42 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910502041809738017a7@mail.gmail.com>
References: <20050122134205.GA9354@wsc-gmbh.de> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>
	 <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net>
	 <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
	 <9e4733910502041809738017a7@mail.gmail.com>
Date: Sat, 05 Feb 2005 02:17:22 +0000
Message-Id: <1107569842.8575.44.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-04 at 21:09 -0500, Jon Smirl wrote:

> How does the hardware die? Are you sure that it is not simply a bug in
> the program doing the POST? Look at the scitech source and you will
> see many BIOS quirks that have to be emulated in order for the post to
> work. If your post program is missing any of these the post won't
> work. So far every time I have encountered a non-working post it was
> fixed by tweaking some things in the post program.

On laptops, it's frequently the case that c000:0003 will jump to a
section of code that is no longer mapped into the address space.
Instead, it's entirely possible that some other section of BIOS will be
mapped there. The resulting behaviour is undefined, and can cause the
hardware to hang.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

