Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWI3VEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWI3VEn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWI3VEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:04:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750886AbWI3VEm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:04:42 -0400
Date: Sat, 30 Sep 2006 14:04:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Eric Rannaud" <eric.rannaud@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       mingo@elte.hu, nagar@watson.ibm.com
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-Id: <20060930140426.37918062.akpm@osdl.org>
In-Reply-To: <5f3c152b0609301352w5bc52653s3e2a28e482c7d69e@mail.gmail.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
	<20060930131310.0d6494e7.akpm@osdl.org>
	<5f3c152b0609301352w5bc52653s3e2a28e482c7d69e@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 22:52:12 +0200
"Eric Rannaud" <eric.rannaud@gmail.com> wrote:

> On 9/30/06, Andrew Morton <akpm@osdl.org> wrote:
> > > On  a 16-way Opteron (8 dual-core 880) with 8GB of RAM, vanilla 2.6.18
> > > crashes early on boot with a BUG.
> >
> > omg what a mess.  Have you tried it with lockdep disabled in config?
> 
> Well, all I can say is that without lockdep it doesn't freeze right
> away (and no BUG, but that's to be expected). I can stress test it if
> you want, although it will take a while, if you think it might be a
> false positive.
> 

Well.  We always appreciate stress-testing, thanks.  But if that finds a
bug, it's presumably a different one from this lockdep-vs-unwinder problem.

You could set CONFIG_UNWIND_INFO=n and CONFIG_STACK_UNWIND=n and reenable
lockdep.  That will a) tell us if there's some lockdep problem and b) will
give us a clearer look at any locking problems which your kernel is
detecting.

