Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752159AbWJNLWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbWJNLWg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 07:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbWJNLWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 07:22:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30993 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752160AbWJNLWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 07:22:31 -0400
Date: Sat, 14 Oct 2006 13:22:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       David Howells <dhowells@redhat.com>,
       James.Bottomley@HansenPartnership.com, pazke@donpac.ru,
       linux-visws-devel@lists.sourceforge.net,
       Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
       Antonino Daplas <adaplas@pol.net>,
       linux-fbdev-devel@lists.sourceforge.net, art@usfltd.com, ak@suse.de,
       discuss@x86-64.org, Robert Hancock <hancockr@shaw.ca>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Gerber <dg-kernel-bug@zapek.com>,
       Dmitry Torokhov <dtor@insightbb.com>, John Stultz <johnstul@us.ibm.com>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Kenny Graunke <kenny@whitecape.org>, Patrick Jefferson <henj@hp.com>,
       Alan Cox <alan@redhat.com>, Christian <christiand59@web.de>,
       Mark Langsdorf <mark.langsdorf@amd.com>, davej@codemonkey.org.uk,
       cpufreq@lists.linux.org.uk
Subject: [1/3] 2.6.19-rc2: known unfixed regressions
Message-ID: <20061014112226.GJ30596@stusta.de>
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061014111458.GI30596@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014111458.GI30596@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known unfixed regressions in 2.6.19-rc2 compared 
to 2.6.18.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : CONFIG_X86_VOYAGER=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Status     : unknown


Subject    : CONFIG_X86_VISWS=y, CONFIG_SMP=n compile error
References : http://lkml.org/lkml/2006/10/7/51
Submitter  : Jesper Juhl <jesper.juhl@gmail.com>
Caused-By  : David Howells <dhowells@redhat.com>
             commit 7d12e780e003f93433d49ce78cfedf4b4c52adc5
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : monitor not active after boot
References : http://lkml.org/lkml/2006/10/5/338
Submitter  : Olaf Hering <olaf@aepfle.de>
Caused-By  : Antonino Daplas <adaplas@pol.net>
             commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
Status     : unknown


Subject    : SMP x86_64 boot problem
References : http://lkml.org/lkml/2006/9/28/330
             http://lkml.org/lkml/2006/10/5/289
Submitter  : art@usfltd.com
Status     : submitter was asked to git bisect
             result of bisecting seems to be wrong


Subject    : do_IRQ: No irq handler for vector
References : http://lkml.org/lkml/2006/10/11/13
Submitter  : Robert Hancock <hancockr@shaw.ca>
Handled-By : "Eric W. Biederman" <ebiederm@xmission.com>
Status     : Andrew: a few people are seeing this. Eric is working it.


Subject    : messed up keyboard events, TSC related
References : http://bugzilla.kernel.org/show_bug.cgi?id=7291
Submitter  : David Gerber <dg-kernel-bug@zapek.com>
Handled-By : Dmitry Torokhov <dtor@insightbb.com>
             John Stultz <johnstul@us.ibm.com>
Status     : Dmitry and John are investigating


Subject    : ide-generic no longer finds marvell controller
References : http://bugzilla.kernel.org/show_bug.cgi?id=7353
Submitter  : Kenny Graunke <kenny@whitecape.org>
Caused-By  : Patrick Jefferson <henj@hp.com>
             commit a4bea10eca68152e84ffc4eaeb9d20ec2ac34664
Handled-By : Alan Cox <alan@redhat.com>
Status     : Alan is investigating


Subject    : cpufreq not working on AMD K8
References : http://lkml.org/lkml/2006/10/10/114
Submitter  : Christian <christiand59@web.de>
Handled-By : Mark Langsdorf <mark.langsdorf@amd.com>
Status     : Mark is investigating


