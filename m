Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130535AbRBATeK>; Thu, 1 Feb 2001 14:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131135AbRBATeA>; Thu, 1 Feb 2001 14:34:00 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:9830 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130535AbRBATdm>; Thu, 1 Feb 2001 14:33:42 -0500
Date: Thu, 1 Feb 2001 11:30:35 -0500 (EST)
From: Chaitanya Tumuluri <chait@getafix.engr.sgi.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: bsuparna@in.ibm.com, lord@sgi.com, linux-kernel@vger.kernel.org,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010201121907.M11607@redhat.com>
Message-ID: <Pine.LNX.4.21.0102011122020.11759-100000@getafix.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, Feb 01, 2001 at 10:25:22AM +0530, bsuparna@in.ibm.com wrote:
> > 
> > Being able to track the children of a kiobuf would help with I/O
> > cancellation (e.g. to pull sub-ios off their request queues if I/O
> > cancellation for the parent kiobuf was issued). Not essential, I guess, in
> > general, but useful in some situations.
> 
> What exactly is the justification for IO cancellation?  It really
> upsets the normal flow of control through the IO stack to have
> voluntary cancellation semantics.
> 
XFS does something called a "forced shutdown" of the filesystem in which
it requires outstanding I/Os issued against file data to be cancelled. 
This is triggered by (among other things) errors in writing out file 
metadata. I'm cc'ing Steve Lord so he can provide more information.

Of course, I was thinking along the lines of an API flushing the requests
out of the elevator at that time .... didn't get too far with it though.

Cheers,
-Chait.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
