Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbRLDFTI>; Tue, 4 Dec 2001 00:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281844AbRLDFS6>; Tue, 4 Dec 2001 00:18:58 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:27520 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S281777AbRLDFSp>; Tue, 4 Dec 2001 00:18:45 -0500
Message-ID: <3C0C5CB2.6000602@optonline.net>
Date: Tue, 04 Dec 2001 00:18:42 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i810 audio patch
In-Reply-To: <3C0C16E7.70206@optonline.net> <3C0C508C.40407@redhat.com> <3C0C58DE.9020703@optonline.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Bryant wrote

> - I haven't seen those oopses again either; they may have been caused 
> by i810_configure_clocking being called twice during the 
> initialization due to a merging goof on my part... 

Ok, I spoke too soon. That piece of code couldn't cause the problem, 
because of the surrounding if (clocking==...

So there may be some VM/buffer related problem lurking under the covers 
still. Originally the oops popped up in kswapd, for me, but I can't 
trigger it again.

