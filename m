Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266842AbSK1Xka>; Thu, 28 Nov 2002 18:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbSK1Xk3>; Thu, 28 Nov 2002 18:40:29 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:51487 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S266842AbSK1Xk2>;
	Thu, 28 Nov 2002 18:40:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: GertJan Spoelman <kl@gjs.cc>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: 2.4.20-rc3 ext3 fsck corruption -- tool update warning needed?
Date: Fri, 29 Nov 2002 00:47:35 +0100
User-Agent: KMail/1.4.3
References: <20021126024739.GA11903@think.thunk.org> <20021127125547.GA7903@think.thunk.org> <20021128224930.GA5861@win.tue.nl>
In-Reply-To: <20021128224930.GA5861@win.tue.nl>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Clemmitt Sigler <siglercm@jrt.me.vt.edu>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Alan Cox <Alan.Cox@linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211290047.35752.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 November 2002 23:49, Andries Brouwer wrote:
> On Wed, Nov 27, 2002 at 07:55:48AM -0500, Theodore Ts'o wrote:
> > Ah, ha.  I think I know what happened.
> >
> > What version of e2fsprogs were you using?  If it was 1.28, that would
> > explain what you saw.  There was a fencepost error that could corrupt
> > directories when it was optimizing/rehashing them.  This bug was fixed
> > in in the next version, which was rushed out the door as a result of
> > this bug.  Fortunately, 1.28 didn't get adopted by any distro's as far
> > as I know
>
> Hmm. On a recently installed SuSE 8.1 machine:
>
> % rpm -qf `which e2fsck`
> e2fsprogs-1.28-18
>
> (maybe the -18 contains the fix?)

No, see below, I copied it from the SuSE security list.

>> This could be slightly off-topic, but isn't data corruption security
>> related?
>> SuSE 8.1 was delivered with e2fsprogs-1.28, which has a "fencepost
>> error" (???) which could cause directory corruption.
>
> According to the maintainer of our e2fsprogs package, this referes to the
> htree (hash tree) stuff in e2fsprogs which is *not* enabled in
> SuSEs version of e2fsprogs.
> 
> HTH
> 
> best regards,
> Rainer Link
> (SuSE Labs)

-- 

    GertJan
