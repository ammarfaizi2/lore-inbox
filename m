Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSFTUtD>; Thu, 20 Jun 2002 16:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315528AbSFTUtC>; Thu, 20 Jun 2002 16:49:02 -0400
Received: from zok.sgi.com ([204.94.215.101]:47780 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315513AbSFTUtB>;
	Thu, 20 Jun 2002 16:49:01 -0400
Message-ID: <005b01c2189b$b390bd40$cc059aa3@engr.sgi.com>
From: "John Hawkes" <hawkes@sgi.com>
To: "Dave Hansen" <haveblue@us.ibm.com>, "Gross, Mark" <mark.gross@intel.com>
Cc: "'Russell Leighton'" <russ@elegant-software.com>,
       "Andrew Morton" <akpm@zip.com.au>, <mgross@unix-os.sc.intel.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
References: <59885C5E3098D511AD690002A5072D3C057B499E@orsmsx111.jf.intel.com> <3D11FE5F.8000207@us.ibm.com>
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles gets large
Date: Thu, 20 Jun 2002 13:47:32 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dave Hansen" <haveblue@us.ibm.com>
> > We'll report out our findings on the lock contention, and throughput
> > data for some other FS then.  I'd like recommendations on what file
> > systems to try, besides ext2.
>
> Do you really need a journaling FS?  If not, I think ext2 is a sure
> bet to be the fastest.  If you do need journaling, try reiserfs and
jfs.

XFS in 2.4.x scales much better on larger CPU counts than do ext3 or
ReiserFS.  That's because XFS is a much lighter user of the BKL in 2.4.x
than ext3, ReiserFS, or ext2.

John Hawkes
hawkes@sgi.com

