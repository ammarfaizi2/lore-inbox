Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264373AbTCYX1K>; Tue, 25 Mar 2003 18:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264387AbTCYX1K>; Tue, 25 Mar 2003 18:27:10 -0500
Received: from air-2.osdl.org ([65.172.181.6]:27616 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264373AbTCYX1J>;
	Tue, 25 Mar 2003 18:27:09 -0500
Date: Tue, 25 Mar 2003 16:40:42 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Deepak Saxena <dsaxena@mvista.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5] Make root PCI bus child of system_bus in device tree
In-Reply-To: <20030325233118.GA16920@xanadu.az.mvista.com>
Message-ID: <Pine.LNX.4.33.0303251637330.999-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Mar 2003, Deepak Saxena wrote:

> On Mar 26 2003, at 00:35, Alan Cox was caught saying:
> > On Tue, 2003-03-25 at 23:16, Deepak Saxena wrote:
> > > All,
> > > 
> > > The following patch updates the PCI subsystem so that root PCI host 
> > > bridges appear as devices hanging off the system bus instead of root 
> > 
> > This seems odd for some systems we support. Older PARISC for example
> > have PCI busses hanging off gecko. I do agree with you for the general
> > case. So systems whose root level bridges are 'normal' should reflect
> > this and I guess others should attach them to the relevant bus.
> > 
> > Over time it seems that PCI is going to become a secondary bus like
> > ISA did as well. In fact it already has in many ways, its just things
> > like VLINK and the Intel hub busses look like PCI to us
> 
> Sounds like more reasoning to just force the caller to provide a parent.
> 'normal' is a moving target and I'd rather not have the code making 
> assumptions and let the platform's kernel developer explictly map
> the PCI bridge into the system.

Actually, that's been the intention all along. The PCI code may not 
support it today (I haven't looked at it in a while), but there is no 
reason why the parent for a host bridge couldn't be set, and the bridge 
show up in the proper place in the hierarchy. 

And, if it isn't set, then it shows up under the root, which makes sense 
physically and conceptually.


	-pat


