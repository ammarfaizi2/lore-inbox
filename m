Return-Path: <linux-kernel-owner+w=401wt.eu-S1750728AbXALOFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXALOFm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 09:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbXALOFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 09:05:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53174 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXALOFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 09:05:41 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: kexec + USB storage in 2.6.19
References: <20070112122444.GA28597@localdomain>
Date: Fri, 12 Jan 2007 07:05:09 -0700
In-Reply-To: <20070112122444.GA28597@localdomain> (Dan Aloni's message of
	"Fri, 12 Jan 2007 14:24:44 +0200")
Message-ID: <m1mz4oe3xm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <da-x@monatomic.org> writes:

> Hello,
>
> After upgrading from 2.6.18.3 to 2.6.19.2 on an x86_64 machine I noticed 
> that the EHCI USB host is unable to work properly after a kexec invocation. 
> This makes it impossible to mount the rootfs in the configuration I'm using.
>
> According to the prints, the irq changes from 23 to 10.
>
> NOTE: Since the device is already connected at boot, I've added a patch 
> that disables the scanning delay for the first detected device, in order 
> to shorten the time it takes for the boot process. It worked on 2.6.18.3, 
> so I wonder what has changed...

At first glance it looks like acpi didn't come on in the kexec'd kernel.
Do you see anything like the line below.
> [ 78.139976] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ

Could your provide the full bootlogs instead of these partial ones?
There is enough context missing I don't think anyone can do more than 
agree you are seeing a problem.

Eric
