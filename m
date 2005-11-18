Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVKRVfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVKRVfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVKRVfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 16:35:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50127 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751023AbVKRVfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 16:35:50 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <1132348998.2830.80.camel@laptopd505.fenrus.org>
References: <20051115212942.GA9828@elf.ucw.cz>
	 <20051115222549.GF17023@redhat.com>
	 <1132342590.25914.86.camel@localhost.localdomain>
	 <1132348998.2830.80.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 22:07:15 +0000
Message-Id: <1132351635.5238.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-11-18 at 22:23 +0100, Arjan van de Ven wrote:
> 1) accessing non-ram memory (eg PCI mmio space) by X and the likes
>    (ideally should use sysfs but hey, changing X for this will take 
>    forever)

Once sysfs supports the relevant capabilities fixing X actually doesn't
look too horrible, the PCI mapping routines are abstracted and done by
PCITAG (ie PCI device). You would need the ISA hole too in some cases.

> 2) accessing bios memory in the lower 1Gb for various emulation like
>    purposes (including vbetool and X mode setting)
> 3) accessing things the kernel sees as RAM
> 
> they are very distinct security wise.

Agreed.

