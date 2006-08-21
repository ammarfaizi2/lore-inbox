Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWHUJSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWHUJSD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWHUJSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:18:03 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:21918 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751726AbWHUJSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:18:01 -0400
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
From: Magnus Damm <magnus@valinux.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: Christoph@sc8-sf-spam2-b.sourceforge.net, Rik van Riel <riel@redhat.com>,
       Linux@sc8-sf-spam2-b.sourceforge.net, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>, List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <200608211103.45175.ak@suse.de>
References: <44E33893.6020700@sw.ru> <200608210948.40870.ak@suse.de>
	 <1156149773.21411.58.camel@localhost>  <200608211103.45175.ak@suse.de>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 18:18:24 +0900
Message-Id: <1156151904.21411.71.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 11:03 +0200, Andi Kleen wrote:
> On Monday 21 August 2006 10:42, Magnus Damm wrote:
> 
> > No problem. The second URL pointed to a x86_64 version where I tried to
> > break out code to make some kind of generic NUMA emulation layer. At
> > that time no one seemed interested in that strategy as a simple resource
> > control solution so I gave that up.
> > 
> > For x86_64 I think it's only worth mucking around with the code if
> > people believe that it is the right way to go for in-kernel resource
> > control.
> 
> Does it by chance fix the existing code? Andrew has been complaining
> (and I could reproduce) that numa=fake=16 makes it triple fault at boot.
> The theory was that it didn't like empty nodes which can happen this way.
> I unfortunately didn't have time to look into it closely so far.

The code does rearrange how the boundaries are calculated, and it may
happen to fix that specific problem. I'll try to find some time later
this week to have a look at it.

> > The x86_64 patches above include code to divide each real NUMA node into
> > several smaller emulated nodes, but that is kind of pointless if people
> > only use it for non-resource control purposes, ie just to play with
> > CPUSETS and NUMA on non-NUMA hardware. For simple purposes like that I
> > think the existing NUMA emulation code for x86_64 works perfectly well.
> > 
> > I still think that i386 users would benefit from NUMA emulation though.
> > If you want me to up-port the i386-specific code just let me know.
> 
> I personally have my doubts about 32bit NUMA -- it will always have
> ZONE_NORMAL only on a single node, which limits it very much. 
> But ok I guess it might be useful to somebody.

Very true. I was mainly thinking about the i386 code as a simple way for
people to play with NUMA and CPUSETS.

/ magnus

