Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUIHERB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUIHERB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 00:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUIHEQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 00:16:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49543 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268848AbUIHEQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 00:16:21 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: multi-domain PCI and sysfs
Date: Tue, 7 Sep 2004 21:16:15 -0700
User-Agent: KMail/1.7
Cc: "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       linux-kernel@vger.kernel.org
References: <9e4733910409041300139dabe0@mail.gmail.com> <20040907161140.29fbfccc.davem@davemloft.net> <9e473391040907203941e4af81@mail.gmail.com>
In-Reply-To: <9e473391040907203941e4af81@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409072116.16050.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 7, 2004 8:39 pm, Jon Smirl wrote:
> On Tue, 7 Sep 2004 16:11:40 -0700, David S. Miller <davem@davemloft.net> 
wrote:
> > On Tue, 7 Sep 2004 18:58:53 -0400
> >
> > Jon Smirl <jonsmirl@gmail.com> wrote:
> > > How many active VGA devices can I have in this system 1 or 4? If the
> > > answer is 4, how do I independently address each VGA card? If the
> > > answer is one, you can see why I want a pci0000 node to hold the
> > > attribute for turning it off and on.
> >
> > I don't know about the above but for a multi-domain system the
> > way it works is that the I/O ports are accessed using a different
> > base address for each domain.
>
> How does this work for IO ports in port space instead of memory mapped IO?

On sn2 at least, it's the same thing.  Each PCI segment has a 'base address' 
that can be used for legacy I/O.  Just add the port you want to access to the 
base and hope that a card responds before a master abort occurs.

Jesse
