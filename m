Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbUKCT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbUKCT3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUKCT1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:27:10 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:60095 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261805AbUKCT0a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:26:30 -0500
From: Gene Heskett <gheskett@wdtv.com>
Reply-To: gheskett@wdtv.com
Organization: occasionally detectable
To: linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 3 Nov 2004 14:26:23 -0500
User-Agent: KMail/1.7
Cc: Valdis.Kletnieks@vt.edu, DervishD <lkml@dervishd.net>,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <200411030751.39578.gene.heskett@verizon.net> <200411031353.39468.gene.heskett@verizon.net> <200411031906.iA3J6QCj018875@turing-police.cc.vt.edu>
In-Reply-To: <200411031906.iA3J6QCj018875@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031426.23880.gheskett@wdtv.com>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.46.51] at Wed, 3 Nov 2004 13:26:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 14:06, Valdis.Kletnieks@vt.edu wrote:
>On Wed, 03 Nov 2004 13:53:39 EST, Gene Heskett said:
>> On Wednesday 03 November 2004 12:44, DervishD wrote:
>> >    Then the children are reparented to 'init' and 'init' gets
>> > rid of them. That's the way UNIX behaves.
>>
>> Unforch, I've *never* had it work that way.  Any dead process I've
>> ever had while running linux has only been disposable by a reboot.
>
>The problem  likely isn't the true "zombie" - the only thing that
> *those* processes have left is a process table entry to save the
> exit code for a wait() syscall that might not happen anytime soon. 
> And unless you have hundreds of them sitting around causing
> pressure on the 32K process limit, they're probably not a big
> problem.
>
>More likely, what you're looking at is some process that has gone
> down into the kernel on some syscall or other and gotten blocked. 
> Since signals aren't delivered until it returns, it ends up
> "unkillable".
>
>Traditionally, a common cause for such wedging was a lost/misplaced
> interrupt from an I/O operation, so a read()/write()/ioctl() call
> wouldn't return because the device hadn't reported it completed.
> (tape drives were notorious for this). Often, power-cycling the I/O
> device would cause an unsolicited interrupt to be generated, which
> would clear the "waiting for interrupt" issue and allow the process
> to return....

Well, since the "device", a bt878 based Haupagge tv card is sitting in 
a pci socket, thats even more drastic than a reboot.

-- 
Cheers, gene
gheskett at wdtv dot com
99.28% setiathome rank, not too bad for a WV hillbilly
