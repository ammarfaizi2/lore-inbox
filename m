Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261842AbSJIQog>; Wed, 9 Oct 2002 12:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbSJIQof>; Wed, 9 Oct 2002 12:44:35 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:10395 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261842AbSJIQod>; Wed, 9 Oct 2002 12:44:33 -0400
Date: Wed, 9 Oct 2002 13:39:01 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Cc: Robert Williamson <robbiew@us.ibm.com>, Paul Larson <plars@us.ibm.com>
Subject: Re: [ANNOUNCE] Linux Test Project October Release Available
Message-ID: <20021009133901.T642@nightmaster.csn.tu-chemnitz.de>
References: <OFFD6D99D7.513F8BA0-ON85256C4C.006B8A1F@pok.ibm.com> <3DA33BF1.3F43E5C0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DA33BF1.3F43E5C0@digeo.com>; from akpm@digeo.com on Tue, Oct 08, 2002 at 01:11:29PM -0700
X-Spam-Score: -21.4 (---------------------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *17zK2J-0002Fi-00*XlJ78vgiliI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 01:11:29PM -0700, Andrew Morton wrote:
> Robert Williamson wrote:
> > 
> > ...
> > - Fix for "writev01" to check for EINVAL on      ( Paul Larson )
> >   2.5.35 and above kernels
> > 
> 
> whoa.  I've been asleep.  The 2.4 kernel _does_ return zero
> if passed a zero segment count.
> 
> So we need to fix 2.5 to do that as well.  Sure, the spec
> appears to allow either, but given that, we should preserve
> the 2.4 behaviour.

I agree. Passing zero counts means "no work to do" and passing
that information is never a problem in any function.

The same goes for a segment with zero len (which is a way to
measure user space to kernel driver latency, if the driver
implements writev and readv).

It's only a "performance bug", if that is used in a real
application, no wrong parameters.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
