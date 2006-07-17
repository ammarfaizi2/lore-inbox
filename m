Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWGQPwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWGQPwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 11:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWGQPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 11:52:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:48871 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750867AbWGQPwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 11:52:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ezdruqOBnJWfvmBPT1A12GNlyX5g6VbruZ9ptZUP1U27sFXLbw/PV0/euopWngdIF/y6fHvqLrkzB8j54ID0GaJQ2gOEgpI7fmxGT7BaIymv7cfUSK7Pi1+VHu77PUK4ZeLLo8k+teSJZQyXy1+plHdPfSlxGru6K5KIIueFzyI=
Message-ID: <f96157c40607170852w48249f0eu9729180b6fe6effb@mail.gmail.com>
Date: Mon, 17 Jul 2006 15:52:36 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Grzegorz Kulewski" <kangur@polcom.net>
Subject: Re: Reiser4 Inclusion
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <44BAFDB7.9050203@calebgray.com>
	 <1153128374.3062.10.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0607171242350.10427@alpha.polcom.net>
	 <20060717160618.013ea282.diegocg@gmail.com>
	 <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the last time I've tried Reiser4 in -mm (4 - 6 weeks ago
approxamitely) I managed to oops by doing:
$ tar xfjv linux-2.6.17.tar.bz2
$ sync

I was calling sync because I was curious as to why XFS seemed to sync
all the time and look and feel slow when compared to ext3. So I
thought let's see what Reiser4 does and the moment I ran sync it
oopsed. Yes this could be a problem with that particular -mm version.

I'd be interested to hear whether this still happens.

no, I'm not making any statements about code quality just curious to
hear as you seem to be using Reiser4 successfully.

On 7/17/06, Grzegorz Kulewski <kangur@polcom.net> wrote:
> On Mon, 17 Jul 2006, Diego Calleja wrote:
> > El Mon, 17 Jul 2006 13:48:02 +0200 (CEST),
> > Grzegorz Kulewski <kangur@polcom.net> escribió:
> >> If someone thinks that Reiser4 is too unstable or evil he can set it to N
> >> and be happy. And if Reiser4 will be abandoned by Namesys and not fixed
> >
> > http://wiki.kernelnewbies.org/WhyReiser4IsNotIn
>
> I already read it when it was posted first. I am reading LKML and
> reiserfs-list for several years and I already read all that arguments,
> flames and so on that were ever pointed here. I think I have enough.
>
> But if we are there:
>
> ""But just include it as experimental code regardless of everything,
> reiser programmers will fix all the problems eventually!"
>
> Well, no and yes. As said, nobody expects reiser 4 to be bug-free, but
> there're some important issues that need to be fixed, the problems is
> that reiser 4 is still working in the important ones. Some of the issues
> fixed in the past included severe design issues, BTW. Others are about
> being well integrated with Linux: duplication of kernel's own
> functionality for no reason, etc. Every piece of code submitted needs to
> have some quality - requesting developers to fix severe issues before
> getting it into the main tree helps to have better code. If you ask
> people people to fix those issues "in the future", they'll be lazy and
> there'll be critical issues around all the time - this has happened in
> Linux in the past. Quality is important, specially under a stable
> development phase. Linux is already being critized a lot for merging new
> features during this stable phase - that criticism happens with the
> current quality control. Imagine what would happen if linux started to
> merge things without caring a bit about what gets merged. Also, consider
> what Reiser 4 is. It's a filesystem, once it gets included in the kernel
> many people WILL use it and will DEPEND on it (your disk format is
> reiser4): Linux needs to ensure that things don't blow up everything."
>
> Why do some people think that users are not already depending on it? They
> are. I don't know how much but I am willing to bet that at least 100
> people. I think that there are some drivers in the kernel that have
> smaller user base.
>
> Keeping Reiser4 out of kernel is even worse (for those users, other users
> that could test this filesystem, for Reiser4 developers and whole
> comunity) than accepting it for a try period with a big fat warning that
> it my be removed if Namesys abandons futher fixing of it (after some time
> to let user migrate).
>
> And any arguments like "if Reiser4 is not in the kernel then people will
> not use and depend on it" are fundamentally flawed IMHO. Everything bad
> that could happen with Reiser4 in the kernel can happen with Reiser4 out
> of it.
>
> It may look like some kernel developers are trying hard not to take
> responsibility for Reiser4 saying that there is very huge difference
> between selecting highly experimental kernel feature that is marked so and
> patching the kernel with it. Sorry but I think there is very little
> difference. And that little difference is only hurting users that want to
> try and test something new.
>
>
> Thanks,
>
> Grzegorz Kulewski
>
>
> PS. I really don't want to begin World War 4 about Reiser4. I just think
> that curious people asking from time to time about _current_ Reiser4
> status should not be treated bad because that could make them stop
> testing and giving back to the open source projects.
>
>
