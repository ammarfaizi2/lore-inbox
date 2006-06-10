Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWFJPO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWFJPO7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWFJPO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:14:59 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57544 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751529AbWFJPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:14:58 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <448AE12E.5060002@s5r6.in-berlin.de>
Date: Sat, 10 Jun 2006 17:11:42 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
CC: weihs@ict.tuwien.ac.at, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread conversion: convert ieee1394 from kernel_thread
References: <20060610143100.GA15536@sergelap.austin.ibm.com> <20060610144205.GA13850@infradead.org>
In-Reply-To: <20060610144205.GA13850@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.367) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Jun 10, 2006 at 09:31:00AM -0500, Serge E. Hallyn wrote:
> 
>>Convert ieee1394 from using deprecated kernel_thread to
>>kthread api.
>>
>>Compiles fine, but unfortunately I am unable to test.
> 
> 
> This patch does various things wrong or at least suboptimal.  See
> '[PATCH] ieee1394_core: switch to kthread API' sent to the ieee1394-devel
> list on the 14th of April for a patch the gets the formalisms right,
> although I wasn't able to test it either.

The patch Christoph is referring to, together with a small fix by Andrew 
Morton, is in -mm and is IMO ready to go into Linux 2.6.18. However this 
patch converts only the khpsbpkt (packet/ transactions handler), not the 
knodemgrd (bus management and protocol driver dispatcher).

Serge, could you reduce your patch to the nodemgr part and resubmit? A 
diff against current -mm would be most welcome. If you develop on top of 
Linus' tree, you could get current 1394 subsystem code which is almost 
identical to latest -mm here:
http://me.in-berlin.de/~s5r6/linux1394/updates/

Thanks,
-- 
Stefan Richter
-=====-=-==- -==- -=-=-
http://arcgraph.de/sr/
