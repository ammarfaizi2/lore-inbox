Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUIHOIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUIHOIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIHOHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:07:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:3752 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269169AbUIHOEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:04:50 -0400
Subject: Re: multi-domain PCI and sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104090723012190c73a@mail.gmail.com>
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409072115.09856.jbarnes@engr.sgi.com>
	 <20040907211637.20de06f4.davem@davemloft.net>
	 <200409072125.41153.jbarnes@engr.sgi.com>
	 <9e47339104090723012190c73a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094648523.11723.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 14:02:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 07:01, Jon Smirl wrote:
> X on GL is going to eliminate all device access from X. Everything

Hardly.

> will be handled from the OpenGL layer. When everything is finished

Nope. It might change the access model for some user space applications.

> Where is the PCI segment base address stored in the PCI driver
> structures? I'm still having trouble with the fact that the PCI driver
> does not have a clear structure representing a PCI segment.  Shouldn't
> there be a structure corresponding to a segment?

Who says PCI is a top level bus. You can have PCI bridges on a different
top level bus on some systems - totally independant. Not sure if you can
hot plug PCI root bridges on any parisc boxes but that would sure be
fun.

> >From what I understand right now the SN2 machine can not have two
> active VGA cards since it does not have two PCI segments. Without two
> segments there is no way to tell the legacy addresses apart.

Some of the NUMA x86 boxes have multiple I/O spaces too. So your I/O
address effectively includes a "system node" section.

