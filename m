Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbSJOUUt>; Tue, 15 Oct 2002 16:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264700AbSJOUUs>; Tue, 15 Oct 2002 16:20:48 -0400
Received: from packet.digeo.com ([12.110.80.53]:48100 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264692AbSJOUUr>;
	Tue, 15 Oct 2002 16:20:47 -0400
Message-ID: <3DAC79FA.5D7A8651@digeo.com>
Date: Tue, 15 Oct 2002 13:26:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: mkanand@us.ibm.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, bhartner@us.ibm.com
Subject: Re: context switches increased in 2.5.40 kernel
References: <3DAC7023.68FEB8A7@us.ibm.com> <20021015.131458.29964525.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Oct 2002 20:26:34.0883 (UTC) FILETIME=[27EAB530:01C27489]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Mala Anand <mkanand@us.ibm.com>
>    Date: Tue, 15 Oct 2002 14:44:35 -0500
> 
>    Does this have anything to do with tcp_wakeup patch?
> 
> Please do not mention patches by name, this tells
> me nothing.  What "tcp_wakeup patch" are you talking
> about?

That would be the patch which uses prepare_to_wait/finish_wait
in networking.  It sped up specweb by 2%, btw.

But that is not present in 2.5.40, and has not been in -mm
since 2.5.40-mm1.  I assume it wasn't present in Mala's testing.
