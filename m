Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVLGRWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVLGRWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 12:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLGRWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 12:22:22 -0500
Received: from fmr15.intel.com ([192.55.52.69]:12470 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751219AbVLGRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 12:22:21 -0500
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
From: Shaohua Li <shaohua.li@intel.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matthew Garrett <mjg59@srcf.ucam.org>,
       linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
In-Reply-To: <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com>
	 <20051206222001.GA14171@srcf.ucam.org>
	 <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
	 <20051207131454.GA16558@srcf.ucam.org>
	 <58cb370e0512070619k17022317v8e871dc3f9cafb9@mail.gmail.com>
	 <20051207143337.GA16938@srcf.ucam.org>
	 <58cb370e0512070645o78569e82y63483a9ae5511f52@mail.gmail.com>
	 <1133970074.544.69.camel@localhost.localdomain>
	 <58cb370e0512070749y68b2f9e9t1c68a3e03f91baa0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 09:22:03 +0800
Message-Id: <1133918523.2936.12.camel@sli10-mobl.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 16:49 +0100, Bartlomiej Zolnierkiewicz wrote:
> On 12/7/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Mer, 2005-12-07 at 15:45 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > OK, I understand it now - when using 'ide-generic' host driver for IDE
> > > PCI device, resume fails (for obvious reason - IDE PCI device is not
> > > re-configured) and this patch fixes it through using ACPI methods.
> 
> I was talking about bugzilla bug #5604.
Sorry for my ignorance in IDE side. From the ACPI spec, there isn't a
generic way to save/restore IDE's configuration. That's why ACPI
provides such methods. I suppose all IDE drivers need call the methods,
wrong?

> > Even in the piix case some devices need it because the bios wants to
> > issue commands such as password control if the laptop is set up in
> > secure modes.
> 
> I completely agree.  However at the moment this patch doesn't seem
> to issue any ATA commands (code is commented out in _GTF) so
> this is not a case for bugzilla bug #5604.
I actually tried to invoke ATA commands using IDE APIs, but can't find
any available one. I'd be very happy if you can give me any hint how to
do it or even you can fix it.

Thanks,
Shaohua

