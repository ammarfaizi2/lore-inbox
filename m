Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWE2HOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWE2HOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWE2HOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:14:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:52951 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWE2HOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:14:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KDB8GKpyOjNoVTQDzczonZqKo2J9X4u1sqthM8oKBFJyr7TQp7S6mQzLs384hHBN/FKou0PNJ2XcjOwHmik3iB7RRBL90z5gNmhPzI0oM3L1hmmNTNg8FkmAi0ZkfmQrJ63DnzxuAjApmqIn2sBH98RFi2sPDRg9J7IQLIo5qf8=
Message-ID: <21d7e9970605290014n198a5295k583667db7e11b004@mail.gmail.com>
Date: Mon, 29 May 2006 17:14:46 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605290025.50100.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605282316.50916.dhazelton@enter.net>
	 <9e4733910605282105t656b7c11i3809105cf261741@mail.gmail.com>
	 <200605290025.50100.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Most of the fbdev drivers use the PCI bus mechanism to find their
> > hardware. Some of the ones that don't run in boxes that don't have a
> > PCI bus. I don't know of any PCI based fbdev drivers not using the PCI
> > support, what is an example of one?
>
>
> Radeon, Riva, Nvidia... Shall I continue? I've only found 2 that actually use
> the PCI binding calls like "pci_get_subsys()" and "pci_dev_get()"

Earlier I asked if you had a copy of LDD v3 for a reason, you seemed
to take this as a direct insult or something like that... please take
a look at the LDD chapter on PCI device drivers, see how the
pci_register_driver and struct pci_driver work in order to register
devices, the pci_get_subsys and stuff is old code.

All the important fb drivers use the correct PCI interface.

The DRM uses the incorrect interface in-tree, and in CVS has both.

I really think you've somehow taken things a bit personally, which
might be understandable, but by the standards of some of the flame
wars on this list, this thread is tame in the least...

Dave.
