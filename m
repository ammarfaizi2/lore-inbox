Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267684AbUG3PBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267684AbUG3PBe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUG3PBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:01:33 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:43753 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S267684AbUG3PB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:01:27 -0400
Message-ID: <410A631B.3020600@colorfullife.com>
Date: Fri, 30 Jul 2004 17:02:51 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:

>btw, if we simply insert a five-second-pause, what problems does that
>leave?  Network Rx, which is OK.  Disk writes will have completed (?). 
>What remains?
>
>  
>
I'd disagree: as soon as the IOMMU is reconfigured/reused Network Rx 
could become a problem: it could point to new io areas of the kexec'ed 
kernel.

Btw, what's the preferred approach to clear the pci master bit: 
forcedeth writes to freed buffers after ifdown right now. I'll add a 
reset into the _close function, but disabling the master bit is probably 
better.

--
    Manfred

