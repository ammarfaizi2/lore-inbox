Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRC0HWn>; Tue, 27 Mar 2001 02:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130683AbRC0HWf>; Tue, 27 Mar 2001 02:22:35 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:16659 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S130660AbRC0HWY>;
	Tue, 27 Mar 2001 02:22:24 -0500
Date: Tue, 27 Mar 2001 09:21:15 +0200
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression testing
Message-ID: <20010327092115.A3974@almesberger.net>
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com> <m1wv9g23t5.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wv9g23t5.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Fri, Mar 23, 2001 at 03:11:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Yes user-mode linux
> could help here (you could stress test the core kernel without worry
> that when it crashes your machine will crash as well).  

A similar approach can be used for very detailed tests of specific
subsystems. E.g. that's what we've started doing, kind of as a by-product
of some other work, with tcsim, which runs most of the traffic control
subsystem in user space. (ftp://icaftp.epfl.ch/pub/linux/tcng/)

The advantage over using UML is that we have a much simpler environment,
allowing for more straightforward integration, and we can exercise tight
control over infrastructure parts like timers or network events. Once
UML is part of the mainstream kernel, it would be interesting to try to
obtain the same functionality with UML too.

Some added goodies include the ability to run kernel code with malloc
debuggers like Electric Fence, which has already helped to find a few
real bugs. (Does EFence work with UML ?)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
