Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315976AbSEGVYV>; Tue, 7 May 2002 17:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315977AbSEGVYU>; Tue, 7 May 2002 17:24:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:51189 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315976AbSEGVYS>;
	Tue, 7 May 2002 17:24:18 -0400
Message-ID: <3CD845D0.ACB6BB2B@vnet.ibm.com>
Date: Tue, 07 May 2002 16:23:28 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions
In-Reply-To: <3CD830BE.CAB7FA96@vnet.ibm.com> <E175BY8-0008S4-00@the-village.bc.nu>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 04:23:30 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 04:23:31 PM,
	Serialize complete at 05/07/2002 04:23:31 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > forms of processor memory barrier instructions.  It is _very_ expensive
> I think I follow
> 
> You have
> 
>         Compiler ordering
>         CPU v CPU memory ordering
>         CPU v I/O memory ordering
>         I/O v I/O memory ordering
> 

Yep, that is a good summary.  And the problem arises from the very large
penalty for the syncronization form used for CPU v I/O ordering.  You
only want to pay that when necessary, certainly not when only CPU v CPU
ordering is required.  The difference can be on the order of a 1000
cycles (depending on many factors, of course).

Dave.
