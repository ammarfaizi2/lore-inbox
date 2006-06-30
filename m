Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWF3WPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWF3WPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWF3WPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:15:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64400 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751151AbWF3WPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:15:53 -0400
Date: Fri, 30 Jun 2006 15:15:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Jones <davej@redhat.com>,
       "Asit K. Mallick" <asit.k.mallick@intel.com>,
       Shaohua Li <shaohua.li@intel.com>,
       Arjan van de Ven <arjan@linux.intel.com>
cc: Alessio Sangalli <alesan@manoweb.com>, Andrew Morton <akpm@osdl.org>,
       alan@lxorguk.ukuu.org.uk, penberg@cs.Helsinki.FI,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ink@jurassic.park.msu.ru, dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
In-Reply-To: <20060630192609.GQ32729@redhat.com>
Message-ID: <Pine.LNX.4.64.0606301458520.12404@g5.osdl.org>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
 <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain>
 <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org> <20060622093606.2b3b1eb7.akpm@osdl.org>
 <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org> <449B0B3C.2020904@manoweb.com>
 <Pine.LNX.4.64.0606301200400.12404@g5.osdl.org> <20060630191914.GP32729@redhat.com>
 <20060630192609.GQ32729@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Jun 2006, Dave Jones wrote:
>  > 
>  > http://www.codemonkey.org.uk/cruft/440/
>  > There's an assortment of docs for the other flavour Intel PCIsets from
>  > that era in the same dir.
> 
> Hrmm, actually that seems to have everything *but* config space definitions.

Yeah, I found those on the intel site too, but nothing with config space 
access info.

It's surprising, actually. I usually have no trouble finding chipset 
config space info for intel chipsets.

Adding a few Intel people to the list, in the hope that they would know at 
least the right person to ask.

Guys: the problem is that the 440MX (PCI ID: 8086:7194) seems to have some 
magic IO register stuff again (probably ACPI or SMBus as usual), and we 
don't know about them, and we don't have a quirk, so when the cardbus IO 
range gets allocated, it can clash and cause trouble.

No docs seem to say _what_ the magic IO addresses are.. Pls help!

		Linus
