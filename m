Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267070AbTCEDFJ>; Tue, 4 Mar 2003 22:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTCEDFJ>; Tue, 4 Mar 2003 22:05:09 -0500
Received: from [216.234.192.169] ([216.234.192.169]:16398 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP
	id <S267070AbTCEDFI>; Tue, 4 Mar 2003 22:05:08 -0500
Subject: Re: Kernel bloat 2.4 vs. 2.5
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, cw@f00f.org, degger@fhm.edu,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1046831831.999.80.camel@phantasy.awol.org>
References: <1046817738.4754.33.camel@sonja>
	<20030304154105.7a2db7fa.akpm@digeo.com> <20030305015957.GA27985@f00f.org>
	<1046830980.999.78.camel@phantasy.awol.org>
	<20030304183208.61b8ed2d.akpm@digeo.com> 
	<1046831831.999.80.camel@phantasy.awol.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 04 Mar 2003 20:13:46 -0700
Message-Id: <1046834041.4114.32.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 19:37, Robert Love wrote:
> On Tue, 2003-03-04 at 21:32, Andrew Morton wrote:
> 
> > well kallsyms is worth 150k.
> > 
> > Do `strings vmlinux' and take a look at it all.
> 
> Oh, yah.  If he has kallsyms enabled that explains most of it.
> 
> 	Robert Love

This shows what taking out kallsyms can do:

   text    data     bss     dec     hex filename
1860575  293780  337404 2491759  26056f kernels/linux-2.4.18/vmlinux
1936720  311656  157792 2406168  24b718 BK/testing-2.5/vmlinux
1936592  437556  158720 2532868  26a604 BK/testing-2.5/vmlinux-with-kallsyms

The 2.5 tree was current yesterday.
The .config files were as "functionally equivalent" as I could make them,
and except for CONFIG_KALLSYMS, were identical for the two 2.5 images.
gcc is 2.96.

Steven

