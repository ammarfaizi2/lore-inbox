Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbUBEBEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 20:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUBEBCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 20:02:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:36997 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265162AbUBEAwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:52:18 -0500
Subject: Re: [PATCH] PCI / OF linkage in sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0402041634440.2086@home.osdl.org>
References: <1075878713.992.3.camel@gaston>
	 <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
	 <20040204231324.GA5078@kroah.com>
	 <Pine.LNX.4.58.0402041522390.2086@home.osdl.org>
	 <1075938633.4029.53.camel@gaston>
	 <Pine.LNX.4.58.0402041601080.2086@home.osdl.org>
	 <1075939994.4371.58.camel@gaston>
	 <Pine.LNX.4.58.0402041634440.2086@home.osdl.org>
Content-Type: text/plain
Message-Id: <1075942252.4029.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 11:50:53 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe just "platform-data" or something. But if "devspec" has magic 
> meaning on a Mac, and since this would be inherently platform-specific 
> _anyway_, I don't actually see any reason to not use "devspec".

No, no magic. Could have been "OF_path" but uppercase are ugly :)

> On some platforms, we might have multiple different entries (eg on a PC we 
> might have pointers to ACPI data, to PnP data and to EFI data, all at the 
> same time. I hope we never will, but maybe there would be reason for it). 
> That would argue _against_ a "generic" name like "platform", and for 
> something that is actually very much specific to the kind of data it 
> points to (eg "of-data" rather than "platform-data").

Maybe anything prefixed by "platform" ? like "platform-fwpath" for OF
spec, etc... 

> End result: I don't think we much care about the name. Whatever makes you
> happy. As long as the source code is clean and something like
> "pcibios_add_platform_entries()" at least makes that come true.

Ok. I dislike #ifdef's too indeed. I was probably too lazy to add the
empty inline to all archs :) I'll do a new patch.

Ben.


