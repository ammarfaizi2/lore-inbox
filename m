Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313549AbSDHETU>; Mon, 8 Apr 2002 00:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313550AbSDHETT>; Mon, 8 Apr 2002 00:19:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:9 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313549AbSDHETS>; Mon, 8 Apr 2002 00:19:18 -0400
Date: Sun, 7 Apr 2002 21:17:17 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Andrew Morton <akpm@zip.com.au>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>, nahshon@actcom.co.il,
        Pavel Machek <pavel@suse.cz>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, joeja@mindspring.com,
        linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <3CB0EF0B.14D48619@zip.com.au>
Message-ID: <Pine.LNX.4.10.10204072115460.19432-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well they are there if they were not deleted by the 2.5 maintainer.
If they were, then feel free to copy and credit the work from 2.4 once I
complete the infrastructure.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 7 Apr 2002, Andrew Morton wrote:

> Richard Gooch wrote:
> > 
> > But I *want* to write while the drive is spun down. And leave it spun
> > down until the system is RAM starved (or some threshold is reached).
> > 
> 
> Yes.  The desirable behaviour for laptops is to defer writes
> for a very long time, or until the user says "sync".
> 
> Mechanisms need to be put in place so that if there are pending
> writes and the disk happens to be spun up for a read, we take
> advantage of that spinup to push out the pending writes at
> the same time.
> 
> This behaviour should be all be enabled by a special "laptop mode"
> switch.
> 
> There's nothing particularly hard in all this...  I'll do a 2.5
> version at some stage.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

