Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWHUJEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWHUJEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 05:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWHUJEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 05:04:15 -0400
Received: from ns2.suse.de ([195.135.220.15]:34239 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750827AbWHUJEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 05:04:13 -0400
From: Andi Kleen <ak@suse.de>
To: Magnus Damm <magnus@valinux.co.jp>
Subject: Re: [ckrm-tech] [PATCH 4/7] UBC: syscalls (user interface)
Date: Mon, 21 Aug 2006 11:03:45 +0200
User-Agent: KMail/1.9.3
Cc: Christoph@sc8-sf-spam2-b.sourceforge.net, Rik van Riel <riel@redhat.com>,
       Linux@sc8-sf-spam2-b.sourceforge.net, ckrm-tech@lists.sourceforge.net,
       Dave Hansen <haveblue@us.ibm.com>, List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>, Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, rohitseth@google.com,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Emelianov <xemul@openvz.org>
References: <44E33893.6020700@sw.ru> <200608210948.40870.ak@suse.de> <1156149773.21411.58.camel@localhost>
In-Reply-To: <1156149773.21411.58.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211103.45175.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 August 2006 10:42, Magnus Damm wrote:

> No problem. The second URL pointed to a x86_64 version where I tried to
> break out code to make some kind of generic NUMA emulation layer. At
> that time no one seemed interested in that strategy as a simple resource
> control solution so I gave that up.
> 
> For x86_64 I think it's only worth mucking around with the code if
> people believe that it is the right way to go for in-kernel resource
> control.

Does it by chance fix the existing code? Andrew has been complaining
(and I could reproduce) that numa=fake=16 makes it triple fault at boot.
The theory was that it didn't like empty nodes which can happen this way.
I unfortunately didn't have time to look into it closely so far.

> The x86_64 patches above include code to divide each real NUMA node into
> several smaller emulated nodes, but that is kind of pointless if people
> only use it for non-resource control purposes, ie just to play with
> CPUSETS and NUMA on non-NUMA hardware. For simple purposes like that I
> think the existing NUMA emulation code for x86_64 works perfectly well.
> 
> I still think that i386 users would benefit from NUMA emulation though.
> If you want me to up-port the i386-specific code just let me know.

I personally have my doubts about 32bit NUMA -- it will always have
ZONE_NORMAL only on a single node, which limits it very much. 
But ok I guess it might be useful to somebody.

-Andi
 
