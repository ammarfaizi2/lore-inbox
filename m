Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbWCRU5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWCRU5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 15:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWCRU5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 15:57:14 -0500
Received: from smtp1.ist.utl.pt ([193.136.128.21]:18071 "EHLO smtp1.ist.utl.pt")
	by vger.kernel.org with ESMTP id S1750902AbWCRU5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 15:57:14 -0500
From: Claudio Martins <ctpm@ist.utl.pt>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.16-rc6: known regressions (v2)
Date: Sat, 18 Mar 2006 20:57:09 +0000
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Avuton Olrich <avuton@gmail.com>, Nathan Scott <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060317143642.GJ3914@stusta.de>
In-Reply-To: <20060317143642.GJ3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603182057.10171.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 17 March 2006 14:36, Adrian Bunk wrote:
> This email lists some known regressions in 2.6.16-rc6 compared to 2.6.15.
>
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you was declared guilty for a breakage or I'm considering you in any
> other way possibly involved with one or more of these issues.
>
> Due to the huge amount of recipients, please trim the Cc when answering.

 [snip...]

>
>
> Subject    : XFS oopses on my box sometimes
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6180
> Submitter  : Avuton Olrich <avuton@gmail.com>
> Handled-By : Nathan Scott <nathans@sgi.com>
> Status     : discussion in the bug
>
>

  Hi Adrian, Nathan and all,

 If think I might have hit this one! 
I managed to get an oops which showed xfs related functions on the backtrace. 
The process involved was "rm" and the specific stress test was some 32 
paralell kernel builds (each one with "make -j8") on a quad Opteron box with 
a 1 TB xfs filesystem. Preemption was disabled.

 After that the machine was still alive, but an fsck.xfs after a reboot showed 
corruption that I was able to repair with xfs_repair. This was also with an 
almost empty filesystem, hence the similarity with the above bug report.

 This was sometime ago, using the git tree from February 23 and unfortunately 
I didn't record the oops and output from xfs_repair. I'll update my git tree 
tonight, rebuild and retest in hopes to find that oops again. FWIW I managed 
to hit this after some 4 to 6 hours of testing so it shouldn't take too long 
to report back.

 See you later...

Best regards

Claudio Martins

