Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSEDMPr>; Sat, 4 May 2002 08:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEDMPq>; Sat, 4 May 2002 08:15:46 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:20490 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S312590AbSEDMPo>; Sat, 4 May 2002 08:15:44 -0400
Date: Sat, 4 May 2002 14:15:30 +0200
From: tomas szepe <kala@pinerecords.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 release 2.4
Message-ID: <20020504121529.GA20335@louise.pinerecords.com>
In-Reply-To: <20020504113954.GB20042@louise.pinerecords.com> <23922.1020513619@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 12 days, 6:39)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Or even worse, suppose $KBUILD_OBJTREE gets reset to some weird
> >value by accident and my whole home dir goes bye bye upon make
> >mrproper?
> <sarcasm>
> Suppose cp gets aliased to rm -rf / by accident and my entire system
> goes bye bye upon cp?
> </sarcasm>

Hmm, I don't think this analogy will do -- working with aliases involving
fileutils as root is a way straight to hell, and hardly anyone ever walks
it. With kbuild-2.5, however, I have to set $KBUILD_OBJTREE every time
I want to build a kernel with objects out of the source dir -- and hey,
is there a single person on this list who's never made a typo on the
command line?

I don't know how to properly emphasize that this *is* asking for problems,
but still I'd be surprised if I were the only one scared by files not
connected to the build getting erased on make mrproper. Hello, anyone? :)

Would it be complicated to only kill the files the build knows it had
created?


-Tomas
