Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281191AbRK3XfJ>; Fri, 30 Nov 2001 18:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281192AbRK3XfA>; Fri, 30 Nov 2001 18:35:00 -0500
Received: from hebe.uva.nl ([145.18.40.21]:54480 "EHLO hebe.uva.nl")
	by vger.kernel.org with ESMTP id <S281191AbRK3Xem>;
	Fri, 30 Nov 2001 18:34:42 -0500
Date: Sat, 1 Dec 2001 00:34:10 +0100 (CET)
From: Kamil Iskra <kamil@science.uva.nl>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <3C053EA8.68BD3613@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111302302420.1736-100000@bubu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, Andrew Morton wrote:

> Maybe you can turn on APM debugging with `apm=debug' on the
> LILO command line, or `modprobe apm debug=1', see if that
> provides a hint.  APM debug mode doesn't seem to do much though.

Yes, exactly.  I've already tried it before, but it didn't give me any
useful clue.  Anyway, you can find the output below.

With kjournald (ext3):

Nov 30 22:38:27 bubu kernel: apm: setting state busy
Nov 30 22:38:28 bubu kernel: apm: setting state busy
Nov 30 22:38:28 bubu apmd[285]: User Suspend
Nov 30 22:38:28 bubu kernel: apm: setting state busy
Nov 30 22:38:28 bubu kernel: apm: setting state busy
Nov 30 22:38:29 bubu kernel: apm: suspend: Unable to enter requested state
Nov 30 22:38:30 bubu apmd[285]: Normal Resume after 00:00:02 (100% unknown) AC power

Nov 30 22:38:34 bubu kernel: apm: setting state busy
Nov 30 22:38:34 bubu apmd[285]: User Suspend
Nov 30 22:38:34 bubu kernel: apm: setting state busy
Nov 30 22:38:34 bubu kernel: apm: setting state busy
Nov 30 22:38:35 bubu kernel: apm: suspend: Unable to enter requested state
Nov 30 22:38:36 bubu apmd[285]: Normal Resume after 00:00:02 (100% unknown) AC power


Without kjournald (ext2):

Nov 30 22:41:04 bubu kernel: apm: setting state busy
Nov 30 22:41:04 bubu apmd[283]: User Suspend
Nov 30 22:41:26 bubu kernel: apm: received normal resume notify
Nov 30 22:41:26 bubu kernel: apm: received power status change notify
Nov 30 22:41:27 bubu apmd[283]: Normal Resume after 00:00:23 (100% unknown) AC power

Nov 30 22:41:36 bubu kernel: apm: setting state busy
Nov 30 22:41:36 bubu kernel: apm: setting state busy
Nov 30 22:41:37 bubu apmd[283]: User Suspend
Nov 30 22:41:37 bubu kernel: apm: setting state busy
Nov 30 22:41:58 bubu kernel: apm: received normal resume notify
Nov 30 22:41:58 bubu kernel: apm: received power status change notify
Nov 30 22:41:59 bubu apmd[283]: Normal Resume after 00:00:22 (100% unknown) AC power


-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlandsc

