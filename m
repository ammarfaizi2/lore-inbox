Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264385AbVBECKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbVBECKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 21:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbVBECKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 21:10:14 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:44768 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266577AbVBECJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 21:09:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=jCMjOGQiWr2N/OTO4G4di57VQjaFDgULOb5dirIOUT17vIPgd5916iTriI8dMWN2I8Th49e66/lJ21P9YDTJ3dnbDptp76YjR0J7Xe2qGc968SFPi01U1oc2XDTBoCGuUbiRqJpIxSmod5eMKG8017Q343fm6iWooNP2oPfXZYs=
Message-ID: <9e4733910502041809738017a7@mail.gmail.com>
Date: Fri, 4 Feb 2005 21:09:22 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Cc: Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1107569089.8575.35.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de> <4202A972.1070003@gmx.net>
	 <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com>
	 <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz>
	 <9e4733910502040931955f5a6@mail.gmail.com>
	 <1107569089.8575.35.camel@tyrosine>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 02:04:49 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Fri, 2005-02-04 at 12:31 -0500, Jon Smirl wrote:
> 
> > Fixing this at kernel boot (resume) time will let user space apps
> > assume that all video cards are reset. That removes a lot of
> > complexity from the user space apps (like X).
> 
> This can't be the default on x86. I have hardware that will die if you
> attempt to POST it after the BIOS has started the OS. Non-x86 should be
> fine, though.

How does the hardware die? Are you sure that it is not simply a bug in
the program doing the POST? Look at the scitech source and you will
see many BIOS quirks that have to be emulated in order for the post to
work. If your post program is missing any of these the post won't
work. So far every time I have encountered a non-working post it was
fixed by tweaking some things in the post program.

> --
> Matthew Garrett | mjg59@srcf.ucam.org
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com
