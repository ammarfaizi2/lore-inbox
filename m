Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751601AbWHUImb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbWHUImb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 04:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWHUImb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 04:42:31 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:31651 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751534AbWHUImb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 04:42:31 -0400
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
In-Reply-To: <200608210948.40870.ak@suse.de>
References: <44E33893.6020700@sw.ru> <20060818094248.cdca152d.akpm@osdl.org>
	 <1156127920.21411.32.camel@localhost>  <200608210948.40870.ak@suse.de>
Content-Type: text/plain
Date: Mon, 21 Aug 2006 17:42:53 +0900
Message-Id: <1156149773.21411.58.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 09:48 +0200, Andi Kleen wrote:
> > You may be looking for the NUMA emulation patches posted here:
> > 
> > http://marc.theaimsgroup.com/?l=linux-mm&m=112806587501884&w=2
> > 
> > There is a slightly updated x86_64 version here too:
> > 
> > http://marc.theaimsgroup.com/?l=linux-mm&m=113161386520342&w=2
> 
> Hmm, I must have missed that version. Seems like a improvement. Best you
> resubmit it, although I'll probably only take it after the .19 merge

No problem. The second URL pointed to a x86_64 version where I tried to
break out code to make some kind of generic NUMA emulation layer. At
that time no one seemed interested in that strategy as a simple resource
control solution so I gave that up.

For x86_64 I think it's only worth mucking around with the code if
people believe that it is the right way to go for in-kernel resource
control.

The x86_64 patches above include code to divide each real NUMA node into
several smaller emulated nodes, but that is kind of pointless if people
only use it for non-resource control purposes, ie just to play with
CPUSETS and NUMA on non-NUMA hardware. For simple purposes like that I
think the existing NUMA emulation code for x86_64 works perfectly well.

I still think that i386 users would benefit from NUMA emulation though.
If you want me to up-port the i386-specific code just let me know.

Thanks,

/ magnus

