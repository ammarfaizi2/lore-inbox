Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293429AbSCKBEf>; Sun, 10 Mar 2002 20:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293434AbSCKBEZ>; Sun, 10 Mar 2002 20:04:25 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32817 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293432AbSCKBEJ>; Sun, 10 Mar 2002 20:04:09 -0500
Date: Mon, 11 Mar 2002 02:05:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: charles-heselton@cox.net, Dan Mann <mainlylinux@attbi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Kernel 2.5.6 Interactive performance
Message-ID: <20020311020512.K8949@dualathlon.random>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPOEPCCFAA.charles-heselton@cox.net> <200203100211.49572.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200203100211.49572.Dieter.Nuetzel@hamburg.de>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 02:11:49AM +0100, Dieter Nützel wrote:
> On Sonntag, 10. März 2002 02:00:02, Charles Heselton wrote:
> > How would you implement these thing?  I'm not on the same technical level
> > that you guys are, and when/if things are out of context, I don't follow.
> > Can you help?
> 
> If you are somewhat open for "new" (experimental) stuff I can prepare a patch 
> on top of 2.4.18 or 2.4.19-pre2 for you.
> 
> But Andrea Arcangeli informed me that vm-29 had a deadlock bug in the recent 
> fixes for the bh headers. vm-28 is fine or soon to be available vm-30.

Confirm. I only wanted to add that only 2.4.19pre2aa1 and vm-29 can
deadlock, all previous -aa kernels and vm-?? patches are rock solid
AFIK. The bug is just fixed, it was a missing UnlockPage. The bug was
introduced while fixing an highmem balancing thing (that nobody ever
reported on production machines so I don't consider such problem a
showstopper, but nevertheless vm-30 will fix both the new pratical and
the old mostly theorical problem).

Andrea
