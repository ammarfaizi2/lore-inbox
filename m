Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315786AbSEDIF1>; Sat, 4 May 2002 04:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSEDIF0>; Sat, 4 May 2002 04:05:26 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:44504 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315786AbSEDIFZ>;
	Sat, 4 May 2002 04:05:25 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15571.38378.376365.3387@argo.ozlabs.ibm.com>
Date: Sat, 4 May 2002 18:03:54 +1000 (EST)
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <15571.33592.365558.215598@argo.ozlabs.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> I seriously doubt that last statement.  Building the global makefile
> takes about 20 seconds on the box I compile on.  On a kernel tree
> without object files I can read all the files in the kernel tree in
> about 0.8 seconds, and I can calculate an md5sum of every file in 3.2
> seconds.  I can do an md5sum of all the Makefile.in's in 0.1 seconds.
> This is with pp_makefile* compiled with -O2 -DNDEBUG=1.

I made a mistake, the time to build the global makefile is in fact
around 12 seconds with -O2 -DNDEBUG=1.  And I should point out that
this is a machine with enough RAM to keep the whole kernel tree in
memory (so disk bandwidth is not an issue).

I still think that the time to build the global makefile is big enough
and obvious enough that many people (including myself) will want to
see it optimized, either by making the process itself more efficient
or by caching the result and re-using it where possible.

Paul.
