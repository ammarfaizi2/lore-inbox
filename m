Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTLDX67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263758AbTLDX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:58:59 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:54660
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263751AbTLDX6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:58:54 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Date: Thu, 4 Dec 2003 17:59:14 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200312041432.23907.rob@landley.net> <20031204214850.GG29119@mis-mike-wstn.matchmail.com>
In-Reply-To: <20031204214850.GG29119@mis-mike-wstn.matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312041759.14385.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 15:48, Mike Fedyk wrote:
> On Thu, Dec 04, 2003 at 02:32:23PM -0600, Rob Landley wrote:
> > You can make a file with a hole by seeking past it and never writing to
> > that bit, but is there any way to punch a hole in a file after the fact? 
> > (I mean other with lseek and write.  Having a sparse file as the
> > result....)
>
> No, Linux doesn't have this feature.
>
> > What are the downsides of holes?  (How big do they have to be to actually
> > save space, is there a performance penalty to having a file with 1000 4k
> > holes in it, etc...)
>
> When you copy them, you need to use tools that know about sparse files and
> how to deal with them.  Also, you will only save space on block aligned
> contiguous zeros at least the length of one block.

I knew that bit.

I was thinking of making a toy that would run periodically against a 
seldom-changed filesystem, find runs of zeroes of a certain minimum size, and 
turn 'em into holes.  The fragmentation might not be worth it, though...

Rob
