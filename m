Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVL3Nce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVL3Nce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVL3Nce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:32:34 -0500
Received: from cmu-24-35-112-99.mivlmd.cablespeed.com ([24.35.112.99]:33684
	"EHLO dad.localdomain") by vger.kernel.org with ESMTP
	id S1750817AbVL3Ncd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:32:33 -0500
Date: Fri, 30 Dec 2005 08:32:26 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@dad.localdomain
To: Ochal Christophe <ochal@kefren.be>
cc: no To-header on input <""@mail.cablespeed.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
In-Reply-To: <43B52F27.20903@kefren.be>
Message-ID: <Pine.LNX.4.63.0512300817290.5860@dad.localdomain>
References: <43B3CA9E.7000804@voltaire.com>  <Pine.LNX.4.63.0512300725300.5860@dad.localdomain>
 <1135946670.2941.21.camel@laptopd505.fenrus.org> <43B52F27.20903@kefren.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >there is no such procedure, because the disk labels are... ON THE DISK.
> >And the initrd reads them from all the disks at boot time to find the
> >one needed. This means that if your disk changes name (for example
> >because of a scsi bus order change or because of a different order you
> >load the device drivers... or even if you forget to compile the sata
> >drivers and suddenly the disk goes from /dev/sda to /dev/hda).... things
> >just remain working
> >

Interesting.  I've been compiling my own kernels for quite some time and 
have never had a boot device end up anywhere except where I thought it 
should.  This includes during the 2.5 craziness when parts of ide support 
was rewritten at least twice.  

> >
> Compile the kernel with support for your hardware built in, i'm assuming you
> eighter build the controller as a module or didn't built it at all

Certainly this is the best advice.  Not only support for the hardware, but 
also ext3 journalling as well as ext2 support.  I think it may be possible 
to end up with ext2 builtin but ext3 journalling as modular.
