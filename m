Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262432AbSJDQ2K>; Fri, 4 Oct 2002 12:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSJDQ2J>; Fri, 4 Oct 2002 12:28:09 -0400
Received: from packet.digeo.com ([12.110.80.53]:36566 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262432AbSJDQ2H>;
	Fri, 4 Oct 2002 12:28:07 -0400
Message-ID: <3D9DC2DE.F6CD0B50@digeo.com>
Date: Fri, 04 Oct 2002 09:33:34 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add safe version of list_for_each_entry() to list.h
References: <OFDA00C8D3.E99FDDA0-ON85256C48.005322C4@pok.ibm.com> <20021004170021.F18545@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 16:33:35.0223 (UTC) FILETIME=[C8D8A070:01C26BC3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> 
> On Fri, Oct 04, 2002 at 10:48:33AM -0500, Mark Peloquin wrote:
> > list_empty() can be used on check list heads *or*
> > to check if a list element is currently in a list,
> > assuming the coder uses list_del_init(). However,
> > if the coder chooses to use list_del() [which sets
> > the prev and next fields to 0] instead, there is no
> > corresponding function to indicate if that element
> > is currently on a list. This function does that.
> 
> That behaviour for list_del is new and, IMNSHO, bogus.  There's now _zero_
> gain in using list_del instead of list_del_init.  akpm changed it about
> 5 months ago with a comment that says:
> 
> "list_head debugging"
> 

It doesn't seem to have caught anyone out, so I guess we can
put it back now.  I'll do a patch.
