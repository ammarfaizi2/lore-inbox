Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTCECAy>; Tue, 4 Mar 2003 21:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTCECAx>; Tue, 4 Mar 2003 21:00:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:24495 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266996AbTCECAx>;
	Tue, 4 Mar 2003 21:00:53 -0500
Date: Tue, 4 Mar 2003 18:11:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: degger@fhm.edu, linux-kernel@vger.kernel.org
Subject: Re: Kernel bloat 2.4 vs. 2.5
Message-Id: <20030304181150.77861903.akpm@digeo.com>
In-Reply-To: <20030305015957.GA27985@f00f.org>
References: <1046817738.4754.33.camel@sonja>
	<20030304154105.7a2db7fa.akpm@digeo.com>
	<20030305015957.GA27985@f00f.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2003 02:11:16.0285 (UTC) FILETIME=[80D336D0:01C2E2BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Tue, Mar 04, 2003 at 03:41:05PM -0800, Andrew Morton wrote:
> 
> > Daniel Egger <degger@fhm.edu> wrote:
> 
> > > I've seen surprisingly few messages about the dramatic size
> > > increase between a simple 2.4 and a 2.5 kernel image.
> 
> > 2.4 has magical size reduction tricks in it which were not brought
> > into 2.5 because we expect that gcc will do it for us.
> 
> I can't see it helping *that* much, for me I have:
> 
>     charon:~/wk/linux% size 2.4.x-cw/vmlinux bk-2.5.x/vmlinux
>        text    data     bss     dec     hex filename
>     2003887  120260  191657 2315804  23561c 2.4.x-cw/vmlinux
>     2411323  267551  181004 2859878  2ba366 bk-2.5.x/vmlinux
> 
>     gcc version 2.95.4 20011002 (Debian prerelease)
> 
> this is for functionally (in terms of .config) equivalent kernels.
> 

Don't know what your point is here, really.

2.4 has hacks to make it smaller.  iirc they were worth ~200 kbytes, or
around 10%.

gcc-3.x string sharing was supposed to make those hacks unnecesary.  However
a quick test here shows gcc-3.2.1 generating a 10% larger 2.5 image than
gcc-2.95.3, so a club may need to be taken to 2.5 as well.

