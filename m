Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264988AbSJaAWC>; Wed, 30 Oct 2002 19:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbSJaAWC>; Wed, 30 Oct 2002 19:22:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:49592 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264988AbSJaAV5>; Wed, 30 Oct 2002 19:21:57 -0500
Message-ID: <3DC0782D.20401@us.ibm.com>
Date: Wed, 30 Oct 2002 16:24:13 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pcibus_to_node() addition to topology infrastructure
References: <3DC06E75.6010003@us.ibm.com> <20021031000326.GA3049@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> This is a nice addition, but just FYI there are SGI systems that have
> PCI busses attached to more than one node.  I guess for now we can just
> round-robin through the attached nodes for the return value.
> 
> Thanks,
> Jesse

Ah, yes...  The p-bricks, i-bricks, etc. right?

Yes, I suppose a round-robin return for the SGI version of the macro 
would work...  Certainly not ideal, but it would work.  The problem is 
if you assume that binding several processes to the node PCI bus X is on 
will ensure that those processes are on the same node.  In this case 
(SGI), it would be a false assumption.  I suppose that's what you get 
for assuming, though? ;)

Cheers!

-Matt

