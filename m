Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262263AbSJOBAL>; Mon, 14 Oct 2002 21:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbSJOBAK>; Mon, 14 Oct 2002 21:00:10 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:20944 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262263AbSJOBAG>; Mon, 14 Oct 2002 21:00:06 -0400
Subject: Re: [Lse-tech] Re: [rfc][patch] Memory Binding API v0.3 2.5.41
From: john stultz <johnstul@us.ibm.com>
To: Matt <colpatch@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Michael Hohnbaum <hohnbaum@us.ibm.com>
In-Reply-To: <3DAB6385.9000207@us.ibm.com>
References: <3DAB5DF2.5000002@us.ibm.com>
	<2004595005.1034616026@[10.10.2.3]>  <3DAB6385.9000207@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Oct 2002 17:55:53 -0700
Message-Id: <1034643354.19094.149.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 17:38, Matthew Dobson wrote:
> Also, right now, memblks map to nodes in a straightforward manner (1-1 
> on NUMA-Q, the only architecture that has defined them).  It will likely 
> look the same on most architectures, too.

Just an FYI: I believe the x440 breaks this assumption. 

There are 2 chunks on the first CEC. The current discontig patch for it
has to drop the second chunk (anything over 3.5G on the first CEC) in
order to work w/ the existing code. However, that will probably need to
be addressed at some point, so be aware that this might affect you as
well. 

thanks
-john

