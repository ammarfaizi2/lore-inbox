Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310504AbSCCFhC>; Sun, 3 Mar 2002 00:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310507AbSCCFgw>; Sun, 3 Mar 2002 00:36:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15633 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310504AbSCCFgk>;
	Sun, 3 Mar 2002 00:36:40 -0500
Message-ID: <3C81B5FC.CD08979A@zip.com.au>
Date: Sat, 02 Mar 2002 21:34:52 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dan Maas <dmaas@dcine.com>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: LFS Support for Sendfile
In-Reply-To: <fa.inaf1vv.one4p5@ifi.uio.no> <fa.esfhmsv.bku814@ifi.uio.no> <02bb01c1c271$7f717700$1a01a8c0@allyourbase>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Maas wrote:
> 
> >     [sendfile(2)] as defined does not support LFS.
> >
> > I wonder does it really need to?  I mean, a loop calling sendfile for
> > 2GB (or whatever) at a time is almost as good, if not better in some
> > ways.
> 
> The 'count' parameter is not the problem, it's the 'offset'. You can't send
> any data beyond 2GB from the beginning of the file...
> 
> And in fact just two days ago I was in a situation where this would have
> been desirable - I was sending parts of a captured DV video stream (the file
> was 6GB)...
> 

We need a sendfile64() system call.  It's really simple,  but
nobody did it.

-
