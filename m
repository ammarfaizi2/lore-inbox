Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265235AbSJWV2w>; Wed, 23 Oct 2002 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265237AbSJWV2w>; Wed, 23 Oct 2002 17:28:52 -0400
Received: from eaganfw1.SGI.COM ([198.149.7.1]:10472 "EHLO
	mandrake.americas.sgi.com") by vger.kernel.org with ESMTP
	id <S265235AbSJWV2v>; Wed, 23 Oct 2002 17:28:51 -0400
Date: Wed, 23 Oct 2002 16:35:36 -0500 (CDT)
From: Robin Holt <holt@sgi.com>
X-X-Sender: holt@mandrake.americas.sgi.com
To: Jan-Frode Myklebust <janfrode@parallab.no>
cc: John Hesterberg <jh@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.44 CSA, Job, and PAGG
In-Reply-To: <20021023232037.A3752@ii.uib.no>
Message-ID: <Pine.LNX.4.44.0210231623490.12293-100000@mandrake.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Jan-Frode Myklebust wrote:

> I see the struct acctcsa has a ac_prid.. Are you planning on adding 
> project level accounting to linux, or is this just leftovers from
> IRIX? 

This is.  I retain the hope that someone will implement project based 
accounting.  Currently, most of the CSA users on Linux are using it for 
system tuning.  The users tend to be people trained in using CSA on Irix 
as one tuning tool and have carried that experience over to Linux.

> 
> I'm not familiar with CSA, but have some experience with using the 
> IRIX system audit trail for accounting (satd). satd isn't handling the
> accounting very well when we get hard hangs or power outages, and no 
> end-of-job record is written. Then we have no account for the cpu-usage 
> of the non-finished jobs at the time.
> 
> Does CSA handle this better, or is it still depending on jobs being 
> finished before writing any accounting records? (a way telling it to
> log periodic intermidiate accounting records would be nice)

Both the job and process accounting record are only generated on process 
termination.  The same problems will exist.

Robin Holt

