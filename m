Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760536AbWLFMij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760536AbWLFMij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760562AbWLFMij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:38:39 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:41305 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760536AbWLFMii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:38:38 -0500
Message-ID: <4576B9CC.5060700@s5r6.in-berlin.de>
Date: Wed, 06 Dec 2006 13:38:36 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alexander Neundorf <a.neundorf-work@gmx.net>
CC: ben.collins@ubuntu.com, linux-kernel@vger.kernel.org, adobriyan@gmail.com,
       linux1394-devel@lists.sourceforge.net, krh@redhat.com
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>		<20061205184921.GA5029@martell.zuzino.mipt.ru>		<4575FF08.2030100@redhat.com> <1165383349.7443.78.camel@gullible>  <457685D1.1080501@s5r6.in-berlin.de> <20061206114036.130470@gmx.net>
In-Reply-To: <20061206114036.130470@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Neundorf wrote:
> Von: Stefan Richter <stefanr@s5r6.in-berlin.de>
>> Mainline's FireWire stack lost a lot of trust
...
> For us it's working well, with no major problems (there was a problem with
> SMP kernels and the arm mapping, but my kernel is not recent and I didn't
> find the time yet to update to current versions, so I could not report the
> bug). We have customers and it works for them.

Perhaps the fix which was released in 2.6.19 is relevant. As always, you
can get it as part of my patchkits too which are currently available for
2.6.16.x and 2.6.18(.x). I had also patchkits for 2.6.1[457].x which I
could revive on request. If need be, I would also try to assist
distributors to identify and backport specific fixes. I am currently
wondering if I should take the time to pick out a collection of fixes
for Adrian's 2.6.16.x series.

> OTOH I heard from some people who wanted to use the 1394 stack for embedded
> devices without PCI and they didn't succeed to add support for their selected
> chipset. 

The ieee1394 core currently dependends on the PCI subsystem for no
obvious reason. The fix probably consists mostly of a rather trivial
conversion from the PCI DMA mapping API to generic DMA mapping. I
actually intend to do this conversion RSN.

Another question is whether the stack-internal APIs are really fit for
non-OHCI chips. There is an unfinished low-level driver for GP2Lynx
which worked to some degree at some point, but other than that I don't
remember positive or negative reports in this department. Maybe proper
documentation of the stack-internal APIs would already help embedded
developers a lot. Furthermore, there may be question marks WRT
interaction of the FireWire stack with architecture specific kernel code.

But back to the subject matter: Clearly, Kristian concentrates on
PCI/OHCI-1394 hardware at the moment. If embedded developers have
specific requirements on the FireWire stack's design, they should IMO
contribute with a list of requirements or maybe even with patches.
-- 
Stefan Richter
-=====-=-==- ==-- --==-
http://arcgraph.de/sr/
