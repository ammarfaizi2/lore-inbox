Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265205AbUFAUNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265205AbUFAUNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUFAUNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:13:32 -0400
Received: from outmx006.isp.belgacom.be ([195.238.2.99]:672 "EHLO
	outmx006.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S265205AbUFAUNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:13:08 -0400
Subject: Re: why swap at all?
From: FabF <fabian.frederick@skynet.be>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406012000.i51K0vor019011@turing-police.cc.vt.edu>
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>
	 <1086114982.2278.5.camel@localhost.localdomain>
	 <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
	 <1086119611.2278.16.camel@localhost.localdomain>
	 <200406012000.i51K0vor019011@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1086120865.2278.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 01 Jun 2004 22:14:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-01 at 22:00, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 01 Jun 2004 21:53:32 +0200, FabF said:
> 
> > I was thinking about some rule e.g. any process using libX* isn't
> > swapped to disk until OOM ...
> 
> Odd.. some of the processes that I'd want kept in memory use libX*,
> but others that also use it are at the top of my list of things to migrate
> out (unlike some, I don't mind if Mozilla or OpenOffice end up out on
> disk after extended inactivity - but if my window manager gets swapped
> out, I get peeved when focus-follows-mouse doesn't and my typing goes
> into the wrong window or some such... ;)
> 
> And that rule doesn't even help much - as it will cause at least some X
> servers themselves to get swapped out.  Here's the list for my X server
> at the moment, as reported by lsof:
> 
> X       13886 root  txt    REG      254,1 1960870       1966 /usr/X11R6/bin/Xorg
> X       13886 root  mem    REG      254,5  105700      12388 /lib/ld-2.3.3.so
> X       13886 root  mem    REG      254,5   50944      12530 /lib/libnss_files-2.3.3.so
> X       13886 root  mem    REG      254,1   64040       1347 /usr/lib/libz.so.1.2.1.1
> X       13886 root  mem    REG      254,5  212972      53335 /lib/tls/libm-2.3.3.so
> X       13886 root  mem    REG      254,5   28008      12513 /lib/libpam.so.0.77
> X       13886 root  mem    REG      254,5   15008      12471 /lib/libdl-2.3.3.so
> X       13886 root  mem    REG      254,5    8332      12515 /lib/libpam_misc.so.0.77
> X       13886 root  mem    REG      254,5   29660      12511 /lib/libgcc_s-3.3.3-20040413.so.1
> X       13886 root  mem    REG      254,5 1451868      53258 /lib/tls/libc-2.3.3.so
> X       13886 root  mem    REG      254,1  647652      32015 /usr/X11R6/lib/modules/extensions/libglx.so.1.0.5341
> X       13886 root  mem    REG      254,1 4954876       8362 /usr/lib/tls/libGLcore.so.1.0.5341
> 
> Nope, no libX* here... ;)
> 
> It's a lot harder than it looks, which explains why we haven't gotten it right
> yet...
> 
Boring....You can't have X root layer swapped to disk as it's often used
! Some quick lsof | grep "libX" gives all frontal applications 'swapping
sensible' .fuser can do 'user resource reverse'.Kernel _can_ 'appl.
resource reverse' as well.

PS: I'm not talking about inactive desktop box.Such box has to be rl 3
and is not meant to be user (geek) relevant :)

FabF


