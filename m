Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271960AbRHVIik>; Wed, 22 Aug 2001 04:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRHVIia>; Wed, 22 Aug 2001 04:38:30 -0400
Received: from mail.informatik.hu-berlin.de ([141.20.20.50]:5047 "EHLO
	mail.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id <S271960AbRHVIiT>; Wed, 22 Aug 2001 04:38:19 -0400
Date: Wed, 22 Aug 2001 10:26:59 +0200 (MEST)
From: Bernhard Wiedemann <wiedeman@informatik.hu-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: translucency lkm
Message-ID: <Pine.LNX.4.10.10108211342100.3774-100000@rudow.informatik.hu-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in short: I wrote a (beta) linux-kernel-module that does translucency
(virtually merging two directories to one)
http://www.informatik.hu-berlin.de/~wiedeman/development/translucency.tgz


the whole story:

three months ago I began building a bootable (stand-alone) linux on CD
but found it cumbersome to burn that CD(RW) again for any little change.
I also wanted some way to change system-files permanently
(e.g store them on disk or nfs)
So I started thinking about overlaying/translucency 
(because I did not want to symlink any potentially writable file)
asking google I found kernel mailing list archives at vger and 
other sites of interest

having found several approaches - mostly at filesystem level (ovlfs, ifs)
I got no working solution with recent kernels (2.2 or 2.4 series) 
so I followed a fellow student's advice to do some kernel-programming
myself. Weeks of reading sources and examples passed
(but I am no expert - so please do not chop my head off for not 
knowing everything - I will be glad if you help me to improve).

I decided for a sys-call-redirecting approach that makes possible
anything the user could do and avoids caring too much about permissions 
but instead introduces some segment/memory and portability issues. 
Yet it works on i386 compatible platforms with 2.4.x kernel 
(about 80% of all features wanted). 
With some trickery I even got a kernel configured and compiled with this
translucency module redirecting any output file to another directory.

it is now about 700 lines of code and works stable (but not as
secure as could be)
It is released under terms of the GPL and I hope that some of you 
(who read so far) will find it useful, do peer-review, send
bugfixes or do something otherwise helpful.

please note that I am not subscribed to the mailing list so please
cc your answer to my email address

yours sincerely
Bernhard M. Wiedemann

