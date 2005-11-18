Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVKRTE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVKRTE7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVKRTE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:04:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:52682 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750776AbVKRTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:04:58 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051115222549.GF17023@redhat.com>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 19:36:29 +0000
Message-Id: <1132342590.25914.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-15 at 17:25 -0500, Dave Jones wrote:
> Just for info: If this goes in, Red Hat/Fedora kernels will fork
> swsusp development, as this method just will not work there.
> (We have a restricted /dev/mem that prevents writes to arbitary
>  memory regions, as part of a patchset to prevent rootkits)

Perhaps it is trying to tell you that you should be using SELinux rules
not kernel hacks for this purpose ?

> Even it were not for this, the whole idea seems misconcieved to me
> anyway.

I'm sceptical too but several Win9x BIOS vendor suspend paths were
implemented in roughly this way. I don't however see how you can
co-ordinate the freeze with outstanding O_DIRECT DMA to user pages for
one item.


