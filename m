Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSFEKUF>; Wed, 5 Jun 2002 06:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFEKUE>; Wed, 5 Jun 2002 06:20:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33989 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314458AbSFEKUC>;
	Wed, 5 Jun 2002 06:20:02 -0400
Date: Wed, 5 Jun 2002 12:19:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020605101947.GZ1105@suse.de>
In-Reply-To: <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <20020604142327.GN1105@suse.de> <3CFCC467.7060702@evision-ventures.com> <20020604145528.GQ1105@suse.de> <3CFCCD91.4020308@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04 2002, Martin Dalecki wrote:
> >WRT the unlikely(), if you have the hints available, why not pass them
> >on?
> 
> Well it's kind like the answer to the question: why don't do it all in hand
> optimized assembler? Or in other words - let's give the GCC guys good

[snip]

If I didn't know better Martin, I would say that you are trolling.
Surely you have better ways to spend your time than to fly fuck [1]
every single patch posted on lkml? :-)

I would agree with your entire email if you were talking about inlining.
Yes we should not inline excessively without a good reason. However, the
likely/unlikely hints provide both clues to the code reader (as someone
else already established) about which is the likely code path or not,
and of course to the compiler. I would agree that profiling would in
some cases be needed before slapping on an unlikely() sticker. These are
the cases where you do not know what the call path is typically like.
When I put unlikely() in there, it's because I know there's a 1:50 ratio
or more. Or maybe a 1:inf ratio, meaning it should only trigger because
of a bug.

[1] To "fuck a fly" is a danish expression, meaning excessive attention
to detail.

-- 
Jens Axboe

