Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbUBDX3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBDX3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:29:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:63670 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264936AbUBDX2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:28:30 -0500
Date: Wed, 4 Feb 2004 15:28:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PCI / OF linkage in sysfs
In-Reply-To: <20040204231324.GA5078@kroah.com>
Message-ID: <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston> <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
 <20040204231324.GA5078@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Greg KH wrote:
> 
> Or, if you really want to be able to get the OF info from the pci device
> in sysfs, why not create a symlink in the pci device directory pointing
> to your OF path in sysfs?  That would seem like the best option.

Where does this stop? Do we start doing the same for all different kinds 
of buses, and all kinds of firmware? 

In other words, instead of having <n> different buses all know about <m>
different kinds of firmware information that they really have nothing else
to do with, it's much better to just have the <m> different kinds of 
firmware information export their own information.

It just sounds _wrong_ to have the PCI layer have knowledge of OF. It has 
nothing to do with OF. For OF information, you should go to the /sys/of 
tree, which has the information that OF knows about (which may, of course, 
then include the information about PCI devices).

		Linus
