Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbUKVSvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUKVSvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbUKVSvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:51:15 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17906 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262335AbUKVStm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:49:42 -0500
Message-ID: <41A234BD.1020207@mvista.com>
Date: Mon, 22 Nov 2004 11:49:33 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
References: <419E6900.5070001@mvista.com> <20041120162622.GA19099@infradead.org>
In-Reply-To: <20041120162622.GA19099@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>Just looking through this and you should share some more code with mips,
>e.g. the mavell register layout should move from asm-mips/marvell.h and
>your file to linux/marvell.h or something, especially as another ppc
>plattform (pegasosII) needs it aswell.  
>

Yes, and there is already include/linux/mv643xx.h that has a bunch of 
64340 definitions which share offset with the 64360 (and some with the 
64260).  However, to be correct, there needs to be a lot of munging.  
mv643xx.h should be renamed to mv64xxx.h and all of the MV64340 macros 
need to be renamed as well.  This ripples into the mips code which I 
didn't want to battle with right now.  I would prefer that this patch go 
in and then submit a separate patch that fixes and combines the hdr 
files & macros they contain.  Doing it that way, there is one patch for 
the ppc bridge support and one patch for the hdr file clean up.  That's 
cleaner than mixing the two (IMHO).  It is on the todo list.

Mark

