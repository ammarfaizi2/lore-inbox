Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316650AbSEWNiQ>; Thu, 23 May 2002 09:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316660AbSEWNiP>; Thu, 23 May 2002 09:38:15 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:53635 "EHLO
	picard.csihq.com") by vger.kernel.org with ESMTP id <S316650AbSEWNiO>;
	Thu, 23 May 2002 09:38:14 -0400
Message-ID: <036901c2025f$0746e2f0$f6de11cc@black>
From: "Mike Black" <mblack@csihq.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0205231301100.1049-100000@localhost.localdomain>
Subject: Re: page_alloc bug in 2.4.17-pre8
Date: Thu, 23 May 2002 09:37:48 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops -- got the wrong version (head was in the wrong kernel space).
This occurred on 2.4.19-pre8

----- Original Message ----- 
From: "Hugh Dickins" <hugh@veritas.com>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Sent: Thursday, May 23, 2002 8:12 AM
Subject: Re: page_alloc bug in 2.4.17-pre8


> On Thu, 23 May 2002, Mike Black wrote:
> > This machine had been up for 2-1/2 days and had run this backup (afio) twice successfully.
> > 
> > Here's line 108 of page_alloc.c:
> >         if (PageLRU(page))
> >                 BUG();
> > 
> > Hopefully this doesn't indicate a CPU problem?  The power supply on this thing blew Saturday but has run OK until now.
> > 
> > May 22 00:51:01 picard kernel: kernel BUG at page_alloc.c:108!
> > May 22 00:51:01 picard kernel: invalid operand: 0000
> > May 22 00:51:01 picard kernel: CPU:    1
> > May 22 00:51:01 picard kernel: EIP:    0010:[swap_duplicate+82/192]    Not tainted
> 
> There were quite a number of reports of those PageLRU BUGs on 2.4.17.
> No idea what fixed them, but 2.4.18 (and 2.4.19-pre) has seemed free
> of them (Ben LaHaise made a plausible change, but closer analysis
> suggested it couldn't really be the fix).  Suggest you upgrade.
> 
> Your oops report, by the way, must have been using the wrong System.map:
> page_alloc.c:108 is in __free_pages_ok(), swap_duplicate() is over in
> swapfile.c.  But no matter, page_alloc.c:108 identifies it well enough.
> 
> Hugh 
> 

