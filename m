Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRHTTWt>; Mon, 20 Aug 2001 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268905AbRHTTWj>; Mon, 20 Aug 2001 15:22:39 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:58780 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S268908AbRHTTW1>;
	Mon, 20 Aug 2001 15:22:27 -0400
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.9 Make thread group id visible in /proc/<pid>/status
In-Reply-To: <E15Yrlh-0006JF-00@the-village.bc.nu> <26210000.998324773@baldur>
	<9lrn8s$t23$1@ncc1701.cistron.net>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 20 Aug 2001 12:15:50 -0700
In-Reply-To: miquels@cistron-office.nl's message of "Mon, 20 Aug 2001 19:09:16 +0000 (UTC)"
Message-ID: <m3snem8rvd.fsf@otr.mynet>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miquels@cistron-office.nl (Miquel van Smoorenburg) writes:

> Switching pid and tgid is something that the LinuxThreads library
> should probably do, but not the kernel. IMHO.

Not possible until the signal handling in the kernel is thread group
aware.  Grab Linus' patch from ten months os so ago, fix it, and get
it into the kernel.  Then we can rewrite the signal handling and make
getpid behave correctly.

Having said this, since this is a known deficiency no program should
use getpid for some critical unless it's absolutely necessary.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
