Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317994AbSHCW1s>; Sat, 3 Aug 2002 18:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318008AbSHCW1s>; Sat, 3 Aug 2002 18:27:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35345 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317994AbSHCW1q>;
	Sat, 3 Aug 2002 18:27:46 -0400
Message-ID: <3D4C5BF0.90CD2850@zip.com.au>
Date: Sat, 03 Aug 2002 15:40:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: question on dup_task_struct
References: <17b65z-1ERay0C@fmrl02.sul.t-online.com> <3D4C57BB.9D735B13@zip.com.au> <3D4C5935.568C1CF2@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Andrew Morton wrote:
> >
> > Oliver Neukum wrote:
> > >
> > > Hi,
> > >
> > > why is GFP_ATOMIC used in fork.c::dup_task_struct?
> >
> > Presumably so that the allocation of the task structure can
> > dip into the emergency pools, giving fork a better chance
> > of succeeding?
> 
> Or maybe it's to _make_ it fail, so we don't loop forever in
> a 1-order allocation?
> 

It's not a 1-order allocation.  I'll go back to sleep now.
