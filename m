Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271779AbRHUSYK>; Tue, 21 Aug 2001 14:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271780AbRHUSYA>; Tue, 21 Aug 2001 14:24:00 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:43423 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S271779AbRHUSXm>;
	Tue, 21 Aug 2001 14:23:42 -0400
Date: Tue, 21 Aug 2001 11:22:46 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: PROBLEM : PCI hotplug crashes with 2.4.9
To: Pierre JUHEN <pierre.juhen@wanadoo.fr>
Cc: Greg KH <greg@kroah.com>, mj@suse.cz, linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net
Message-id: <0b5c01c12a6e$47b68e40$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <3B816617.F5C1CD24@wanadoo.fr> <20010820123625.A31374@kroah.com>
 <08d401c129ca$94ebd2a0$6800000a@brownell.org> <3B82A2C5.48E4DFC@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was a bit lazy, writing by memory : you are right the system says
>
> "pcimodules is scanning more than 00:00.0"
>
> but onluy this line and crashes. Under 2.4.6, it scans all the pci
> adresses.

Then you should be able to try reproducing this by hand,
without hotplug scripts at all.  Is it "pcimodules" that's making
it crash?  Or is it the subsequent "modprobe" commands?
Neither of those is supposed to be able to crash the kernel.

You should be able to track this down pretty easily.  Disable
the /etc/hotplug/pci.rc script for a moment ("pci.rc-"), boot, then
run it by hand like "sh -x pci.rc start".  That's pretty much the way
it's done at boot time, except that by passing the "-x" you get
some nice debug output, and will be able to see what user
mode command caused the crash.

- Dave



