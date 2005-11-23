Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbVKWX0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbVKWX0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKWX0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:26:46 -0500
Received: from [195.110.122.101] ([195.110.122.101]:11145 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S1750779AbVKWX0p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:26:45 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: Dual opteron various segfaults with 2.6.14.2 and earlier kernels
Date: Thu, 24 Nov 2005 00:26:41 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <200511231537.49320.cova@ferrara.linux.it> <200511232255.57716.andrew@walrond.org>
In-Reply-To: <200511232255.57716.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511240026.42212.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 23:55, mercoledì 23 novembre 2005, Andrew Walrond ha scritto:
> On Wednesday 23 November 2005 14:37, Fabio Coatti wrote:
> > Hi all,
> > I'm seeing several segfaults on a couple of HP DL585 Dual Opterons, 8Gb
> > ram each.
> >
> > The segfaults are like this:
> > factorial[17031]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffe287e0 error 4
> > factorial[17034]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffc6f450 error 4
> > factorial[17038]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffdbd060 error 4
> > factorial[17044]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffb48fa0 error 4
> > factorial[17046]: segfault at 0000000000020f31 rip 00000000004035ae rsp
> > 00007fffffc2a7f0 error 4
> > ld[3997]: segfault at 0000000000000020 rip 00002aaaaad1a525 rsp
> > 00007fffffa8e960 error 4
> > ld[4234]: segfault at 0000000000000020 rip 00002aaaaad1a525 rsp
> > 00007fffffc3a1e0 error 4
> >
> > This is only an example; often during some "make", also sed segfaults
> > (!). I've seen this with 2.6.12, 2.6.13.4, 2.6.14.2
>
> The symtoms look just like the TLB flush filter errata which affected SMP
> x86_64 kernels upto (at least) 2.6.13.4. IIRC it was fixed for 2.6.14 (at
> least I stopped using the patch after 2.6.13.4).
>
> Are you sure you saw this with 2.6.14+ ?


yes, uname says  2.6.14.2; on a second identical machine, I've just seen this:


factorial[2352]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
00007fffffbfaf60 error 4
factorial[2354]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
00007fffffe3fc70 error 4
factorial[2361]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
00007fffffb07c50 error 4
factorial[2358]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
00007fffffb07c50 error 4
factorial[2363]: segfault at 0000000000020f31 rip 00000000004035ae rsp 
00007fffffe6d270 error 4

the kernel and HW are the same.

