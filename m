Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270688AbRHSTBa>; Sun, 19 Aug 2001 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270684AbRHSTBU>; Sun, 19 Aug 2001 15:01:20 -0400
Received: from cpe.atm0-0-0-122182.bynxx2.customer.tele.dk ([62.243.2.100]:10592
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S270676AbRHSTBF>; Sun, 19 Aug 2001 15:01:05 -0400
Message-ID: <3B800CF9.9000606@fugmann.dhs.org>
Date: Sun, 19 Aug 2001 21:01:13 +0200
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en-us
MIME-Version: 1.0
To: chuckw@ieee.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for comments on Bottom-Half/Tasklet/SoftIRQ
In-Reply-To: <20010818231704.A2388@ieee.org> <3B7FF06A.4090606@fugmann.dhs.org> <20010819013508.B2388@ieee.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chuckw@ieee.org wrote:
> Thanks
> 
> 	So, Bottom halves don't need to be re-entrant as do tasklets.  SoftIRQ's
> need to be re-entrant.  The advantage of tasklets is that each tasklet can
> be farmed out to different CPU's AND they don't need to be re-entrant 
> because only one instance is allowed at a time.  I think I got it.

That is 100% correct.

> 
> 	Could you direct me to some code in the kernel which uses tasklets
> so I can see the inner workings?

Actually very few systems in the kernel has been rewritten to use 
tasklets instead og BH's.

But as they are very simillar to BH's, you should be able to use the 
same thinking, its just a new API.

Take a look at include/linux/interrupt.h
(or http://lxr.linux.no/source/include/linux/interrupt.h, an invaluable 
source when coding for linux).

Regards
Anders Fugmann

