Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262390AbSJOBMj>; Mon, 14 Oct 2002 21:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262403AbSJOBMj>; Mon, 14 Oct 2002 21:12:39 -0400
Received: from franka.aracnet.com ([216.99.193.44]:12499 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262390AbSJOBMh>; Mon, 14 Oct 2002 21:12:37 -0400
Date: Mon, 14 Oct 2002 18:08:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: john stultz <johnstul@us.ibm.com>, Matt <colpatch@us.ibm.com>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <2007503407.1034618934@[10.10.2.3]>
In-Reply-To: <1034643354.19094.149.camel@cog>
References: <1034643354.19094.149.camel@cog>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Also, right now, memblks map to nodes in a straightforward manner (1-1 
>> on NUMA-Q, the only architecture that has defined them).  It will likely 
>> look the same on most architectures, too.
> 
> Just an FYI: I believe the x440 breaks this assumption. 
> 
> There are 2 chunks on the first CEC. The current discontig patch for it
> has to drop the second chunk (anything over 3.5G on the first CEC) in
> order to work w/ the existing code. However, that will probably need to
> be addressed at some point, so be aware that this might affect you as
> well. 

No, the NUMA code in the kernel doesn't support that anyway.
You have to use zholes_size, and waste some struct pages,
or config_nonlinear. Either way you get 1 memblk.

M.

