Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261726AbREPAO5>; Tue, 15 May 2001 20:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbREPAOq>; Tue, 15 May 2001 20:14:46 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:49606 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261724AbREPAOc>; Tue, 15 May 2001 20:14:32 -0400
Date: Tue, 15 May 2001 17:13:12 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: LANANA: To Pending Device Number Registrants
To: Alexander Viro <viro@math.psu.edu>
Cc: mjfrazer@somanetworks.com, lkml <linux-kernel@vger.kernel.org>
Message-id: <049e01c0dd9c$ff9eae80$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.GSO.4.21.0105151927480.22958-100000@weyl.math.psu.edu>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I suppose that for network interface names, some convention for
> > interface ioctls would suffice to solve that "identify" step.  PCI
> > devices would return the slot_name, USB devices need something
> > like a patch I posted to linux-usb-devel a few months back.
> 
> This is crap.

Only the ioctl part, though I confess to trolling for a better proposal ... :)


> If you want to do it - do it right. Accessing /dev/eth/<n>/MAC
> is trivial. Wanking with ioctls is not. And populating such tree
> is as simple as it gets.

For links without a stable MAC, /.../net/<ifname>/{pci-slot,usb-path,...}
is more like it, but I think that class of solution should be fine.

Now ... what should be the roles of "regular" file ops, devfs, usbdevfs,
procfs, and "devreg" ?  That's the part that doesn't seem simple yet.
I'd expect a few rounds of code/design changes.

- Dave




