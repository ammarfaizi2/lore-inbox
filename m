Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTEQUSB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 16:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTEQUSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 16:18:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19884
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261807AbTEQURz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 16:17:55 -0400
Date: Sat, 17 May 2003 22:30:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: dak@gnu.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030517203045.GZ1429@dualathlon.random>
References: <x54r3tddhs.fsf@lola.goethe.zz> <20030517174100.GT1429@dualathlon.random> <x5r86x74ci.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x5r86x74ci.fsf@lola.goethe.zz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 09:36:29PM +0200, David Kastrup wrote:
> Andrea Arcangeli <andrea@suse.de> writes:
> 
> > On Sat, May 17, 2003 at 01:22:23PM +0200, David Kastrup wrote:
> > > 
> > > I have a problem with Emacs which crawls when used as a shell.  If I
> > > call M-x shell RET and then do something like
> > > hexdump -v /dev/null|dd count=100k bs=1
> > 
> > this certainly can't be it
> > 
> > andrea@dualathlon:~> hexdump -v /dev/null|dd count=100k bs=1
> > 0+0 records in
> > 0+0 records out
> 
> Argl.  Substitute /dev/zero in the obvious place.  My stupidity.
> 
> Here is a test file for generating further stats from within Emacs.
> You can call it interactively from within Emacs with
> M-x load-library RET testio.el RET
> M-x make-test RET
> 
> and you can use it from the command line (if you really must) with
> emacs -batch -q -no-site-file -l testio.el -eval "(progn(make-test t
>   'kill-emacs)(sit-for 100000))"
> 


> 
> 
> It will then output the read stuff from the process followed by
> statistics of block sizes over each second it ran.
> 
> The interactive session tends to be somewhat worse, but the command
> line version is bad enough for a demonstration.

this is within emacs:

   1 blocks with size   95
   1 blocks with size  146
   1 blocks with size  175
   1 blocks with size  189
   1 blocks with size  199
   2 blocks with size  231
   2 blocks with size  232
   1 blocks with size  233
   1 blocks with size  238
   1 blocks with size  241
   1 blocks with size  242
   1 blocks with size  243
   1 blocks with size  244
   1 blocks with size  245
   1 blocks with size  247
   1 blocks with size  252
   2 blocks with size  257
   1 blocks with size  260
   2 blocks with size  261
   2 blocks with size  262
   1 blocks with size  263
   1 blocks with size  266
   1 blocks with size  271
   1 blocks with size  276
   1 blocks with size  282
   1 blocks with size  283
   1 blocks with size  289
   1 blocks with size  296
   1 blocks with size  297
   1 blocks with size  299
   1 blocks with size  300
   2 blocks with size  302
   1 blocks with size  304
   1 blocks with size  306
   2 blocks with size  307
   1 blocks with size  308
   1 blocks with size  310
   1 blocks with size  311
   3 blocks with size  312
   1 blocks with size  313
   2 blocks with size  315
   1 blocks with size  316
   1 blocks with size  317
   1 blocks with size  322
   1 blocks with size  324
   1 blocks with size  330
   1 blocks with size  345
   1 blocks with size  347
   2 blocks with size  355
   2 blocks with size  359
   2 blocks with size  363
   1 blocks with size  368
   1 blocks with size  369
   2 blocks with size  373
   1 blocks with size  374
   2 blocks with size  375
   1 blocks with size  383
   1 blocks with size  384
   2 blocks with size  385
   1 blocks with size  386
   2 blocks with size  387
   1 blocks with size  389
   1 blocks with size  391
   1 blocks with size  392
   2 blocks with size  393
   3 blocks with size  394
   1 blocks with size  397
   2 blocks with size  398
   4 blocks with size  400
   1 blocks with size  402
   1 blocks with size  405
   1 blocks with size  409
   1 blocks with size  414
   1 blocks with size  418
   1 blocks with size  420
   4 blocks with size  423
   1 blocks with size  424
   1 blocks with size  428
   1 blocks with size  429
   1 blocks with size  430
   1 blocks with size  432
   1 blocks with size  433
   1 blocks with size  436
   1 blocks with size  437
   1 blocks with size  443
   2 blocks with size  445
   1 blocks with size  448
   2 blocks with size  451
   1 blocks with size  453
   1 blocks with size  455
   1 blocks with size  472
   2 blocks with size  485
   1 blocks with size  490
   1 blocks with size  498
   1 blocks with size  504
   1 blocks with size  505
   1 blocks with size  510
   1 blocks with size  512
   2 blocks with size  533
   2 blocks with size  537
   1 blocks with size  540
   1 blocks with size  545
   1 blocks with size  551
   1 blocks with size  557
   2 blocks with size  562
   1 blocks with size  571
   1 blocks with size  572
   1 blocks with size  573
   1 blocks with size  578
   1 blocks with size  579
   1 blocks with size  582
   1 blocks with size  588
   2 blocks with size  596
   1 blocks with size  598
   1 blocks with size  599
   1 blocks with size  600
   1 blocks with size  602
   2 blocks with size  610
   1 blocks with size  616
   1 blocks with size  620
   2 blocks with size  623
   1 blocks with size  628
   1 blocks with size  629
   1 blocks with size  630
   2 blocks with size  638
   1 blocks with size  639
   2 blocks with size  640
   1 blocks with size  641
   1 blocks with size  642
   1 blocks with size  644
   1 blocks with size  648
   1 blocks with size  650
   1 blocks with size  651
   1 blocks with size  652
   1 blocks with size  654
   1 blocks with size  656
   1 blocks with size  657
   1 blocks with size  659
   1 blocks with size  662
   1 blocks with size  665
   1 blocks with size  667
   2 blocks with size  670
   1 blocks with size  672
   1 blocks with size  679
   1 blocks with size  687
   1 blocks with size  720
   1 blocks with size  735
   1 blocks with size  746
   1 blocks with size  754
   1 blocks with size  775
   1 blocks with size  834
   1 blocks with size  844
   1 blocks with size  894
   1 blocks with size  896
   1 blocks with size  906
   1 blocks with size  928
   1 blocks with size  980
   2 blocks with size  987
   1 blocks with size  991
   1 blocks with size  998
   1 blocks with size 1023
   8 blocks with size 1024

from the shell prompt:

   6 blocks with size   26
   5 blocks with size   27
  14 blocks with size   28
  10 blocks with size   29
   4 blocks with size   30
   2 blocks with size   31
   2 blocks with size   32
   2 blocks with size   33
   4 blocks with size   34
   1 blocks with size   35
   1 blocks with size   36
   2 blocks with size   38
   2 blocks with size   39
   1 blocks with size   41
   1 blocks with size   45
   1 blocks with size   46
   3 blocks with size   48
   1 blocks with size   49
   1 blocks with size   52
   3 blocks with size   55
   1 blocks with size   57
   1 blocks with size   58
   2 blocks with size   60
   1 blocks with size   61
   1 blocks with size   62
   1 blocks with size   63
   1 blocks with size   65
   1 blocks with size   71
   2 blocks with size   75
   1 blocks with size   79
   1 blocks with size   86
   1 blocks with size  120
   1 blocks with size  128
   2 blocks with size  147
   1 blocks with size  190
   1 blocks with size  233
   1 blocks with size  241
   1 blocks with size  250
   1 blocks with size  269
   1 blocks with size  273
   1 blocks with size  407
   1 blocks with size  564
   1 blocks with size  614
   2 blocks with size  626
   1 blocks with size  667
   1 blocks with size  680
   1 blocks with size  709
   1 blocks with size  711
   1 blocks with size  712
   1 blocks with size  719
   1 blocks with size  722
   1 blocks with size  729
   1 blocks with size  732
   2 blocks with size  737
   1 blocks with size  759
   1 blocks with size  772
   1 blocks with size 1014
   5 blocks with size 1023
  31 blocks with size 1024


my emacs is:

GNU Emacs 21.2.1
Copyright (C) 2001 Free Software Foundation, Inc.
GNU Emacs comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of Emacs
under the terms of the GNU General Public License.
For more information about these matters, see the file named COPYING.

> 
> It is obvious that during most of the time, the pipe only receives
> single characters.
> 
> Again, I am pretty sure that Emacs is at fault too, but I don't
> understand the implications of what scheduling behavior causes the
> pipes to remain mostly empty, with an occasional full filling.  It
> would be better if Emacs would not be context-switched into the
> moment something appears in the pipe, but if the writer to the pipe
> would keep the opportunity to fill'er'up until it is either preempted
> or needs to wait.  If there was some possibility to force this
> behavior from within Emacs, this would be good to know.

I don't see any slowdown here.

As said the 100k bs will lead to just 1 syscall for lots of I/O, this
made me think the lowlatency fixes can be related. So I would suggest
you to try to reproduce with my 2.4 tree or with 2.5 + -preempt enabled.

Just for the record, this is the patch I'm talking about (you can apply
it easily to other 2.4, this should really be merged into mainline too):

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/kernels/v2.4/2.4.21rc2aa1/9998_lowlatency-fixes-12

Andrea
