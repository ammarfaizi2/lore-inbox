Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbTJRUlf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbTJRUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:41:35 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:60814
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261838AbTJRUle convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:41:34 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Where's the bzip2 compressed linux-kernel patch?
Date: Sat, 18 Oct 2003 15:38:35 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200310180018.21818.rob@landley.net> <20031018164337.GB11066@wohnheim.fh-wedel.de>
In-Reply-To: <20031018164337.GB11066@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200310181538.35301.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 October 2003 11:43, Jörn Engel wrote:
> On Sat, 18 October 2003 00:18:21 -0500, Rob Landley wrote:
> > I just rewrote bunzip2 for busybox in about 500 lines of C (and a good
> > chunk of that's comments), which comiles to a bit under 7k.
>
> 5140 on my machine, compared to 9436 for the stock decompress.o.  Nice.
>
> Does it survive the bzip2 testcases?

The decompression-side ones, yes.  (Modulo different command line arguments, 
and that I didn't implement the "small mode" that's slower but uses less 
memory.  That would probably only add a couple hundred bytes, and I could 
make it a compile time option, but I just haven't gotten around to it yet.  
If somebody wants to send me a patch... :)

Mostly I've been repeatedly extracting linux-2.6.0-test6.tar.bz2 as my 
testcase.  Much more of a workout. :)

> > P.S.  If you're curious about the micro-bunzip code, it's in busybox CVS:
> > http://www.busybox.net/cgi-bin/cvsweb/busybox/archival/libunarchive/decom
> >press_bunzip2.c
>
> Not pretty with 80 columns, but it looks good at first glance.

Manuel Novoa submitted a patch that sped things up over 10% (seriously cool, 
that's why we're faster than the original), but broke the 80 column thing 
(mostly a couple return statements that need to be on the next line).

I'm happy to take a patch to clean it up. :)

> And surely more fun to work on than the zlib-inspired code from Julian.

That was the original reason for doing this, yes. :)

Eric Anderson pointed me to the new home of the kernel bunzip patch, which is 
at "http://shepard.kicks-ass.net/~cc/", and I'll take a stab at porting it to 
2.6.0-test8 as the mood strikes me. :)

> Jörn

Rob
