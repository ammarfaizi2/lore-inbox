Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRFDTlb>; Mon, 4 Jun 2001 15:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263692AbRFDTlW>; Mon, 4 Jun 2001 15:41:22 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:31958 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262058AbRFDTlD>; Mon, 4 Jun 2001 15:41:03 -0400
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: aki.jain@stanford.edu (Akash Jain), linux-kernel@vger.kernel.org,
        su.class.cs99q@nntp.stanford.edu
Subject: Kernel Stack usage [was: [PATCH] fs/devfs/base.c]
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com> <E156o6c-0005AB-00@the-village.bc.nu> <200106040707.f5477ET11421@vindaloo.ras.ucalgary.ca> <m2elt011y6.fsf@sympatico.ca>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 04 Jun 2001 15:39:02 -0400
In-Reply-To: Bill Pringlemeir's message of "04 Jun 2001 15:26:25 -0400"
Message-ID: <m2ae3o11d5.fsf_-_@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Bill Pringlemeir <bpringle@sympatico.ca> writes:

  > There was a discussion on comp.arch.embedded about bounded stack
  > use.  It is fairly easy to calculate the stack usage for call
  > trees, but much more difficult for `DAGs'.  Ie, a recursive
  > functions etc.  I don't know about the policy on recursion in the
  > kernel, but I think it would be bad.

  > Perhaps the checker could be modified to keep track of the call
  > tree and find the largest value used in the tree.  Each function
  > will have a maximum, to which you should add the interrupt
  > handling overhead, which would be calculated in a similar way.
  > This will work if you do not allow re-entrant interrupts and you
  > do not have any `cycles' in the function call hierarchies.

Sorry, I neglected the important case of `alloca', and other variable
length stack allocation functions/constructs.  Maybe this becomes too
restrictive to be useful.

regards,
Bill Pringlemeir

