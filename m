Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312181AbSDEEN7>; Thu, 4 Apr 2002 23:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312219AbSDEENt>; Thu, 4 Apr 2002 23:13:49 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:20928 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S312181AbSDEENk>;
	Thu, 4 Apr 2002 23:13:40 -0500
Date: Fri, 5 Apr 2002 13:13:30 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
X-X-Sender: tomh@holly.crl.go.jp
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre5
In-Reply-To: <Pine.LNX.4.21.0204041627580.10117-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0204051300130.9007-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Marcelo Tosatti wrote:

> Could you please try to reproduce with 2.4.19-pre4 ?

OK, I could, so I searched back and -pre1 was OK.  This behavior
showed up in -pre2.  It seems to be related to the mm changes.
Unfortunately I don't know how to back those out safely to check that.

To repeat, I set up a window that has to be redrawn (no backing
store), then use ee (electric eyes) to scroll through 50 or so JPGs
then go back to redraw the aforementioned window.  In -pre2 I get 5
sec freezes and no disk IO during the interval, so it seems like a
memory management thing.

Any tests I could do?  A -pre2 patch without the mm changes?

> On Thu, 4 Apr 2002, Tom Holroyd wrote:
>
> > AlphaPC 264DP 666 MHz (Tsunami, UP)
> > 1GB RAM
> > gcc version 3.0.3
> > ... a window that should
> > refresh (no backing store) right away causes long (2~5 sec) freezes.

