Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUJaBJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUJaBJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbUJaBJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:09:59 -0400
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:50077
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261458AbUJaBJ4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:09:56 -0400
Date: Sun, 31 Oct 2004 01:09:54 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
In-Reply-To: <1099176751.25194.12.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0410310155080.11293@ppg_penguin.kenmoffat.uklinux.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> 
 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> 
 <20041030222720.GA22753@hockin.org>  <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
  <1099178405.1441.7.camel@krustophenia.net> <1099176751.25194.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Oct 2004, Alan Cox wrote:

> On Sul, 2004-10-31 at 00:20, Lee Revell wrote:
> > I think very few application developers understand the point Linus made
> > - that bigger code IS slower code due to cache misses.  If this were
> > widely understood we would be in pretty good shape.
>
> On my laptop both Openoffice and gnome are measurably faster if you
> build the lot with -Os (except a couple of image libs)
>

Depends how much of gnome you use.  I used to swear by -Os for
non-toolchain stuff, but in the end I got bitten by gnumeric on x86.
http://bugs.gnome.org/show_bug.cgi?id=128834 is similar, but in my case
opening *any* spreadsheet would cause gnumeric to segfault (gcc-3.3
series).  Add in the time spent rebuilding gnome before I found this bug
report, and adding extra parts of gnome just in case I missed something,
and the time to load it is irrelevant.  Since then I've had an anecdotal
report that -Os is known to cause problems with gnome.  I s'pose people
will say it serves me right for doing my initial testing on ppc which
didn't have this problem ;)  The point is that -Os is *much* less tested
than -O2 at the moment.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

