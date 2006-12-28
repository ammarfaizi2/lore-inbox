Return-Path: <linux-kernel-owner+w=401wt.eu-S965038AbWL1WjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWL1WjL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbWL1WjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:39:10 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1517 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965039AbWL1WjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:39:08 -0500
Date: Thu, 28 Dec 2006 23:39:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ben Castricum <mail0612@bencastricum.nl>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       Berthold Cogel <cogel@rrz.uni-koeln.de>,
       Ben Collins <ben.collins@ubuntu.com>,
       Daniel Holbach <daniel.holbach@ubuntu.com>,
       Komuro <komurojun-mbn@nifty.com>, Michael Reske <micha@gmx.com>,
       Ayaz Abdulla <aabdulla@nvidia.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>, discuss@x86-64.org,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Steve Wise <swise@opengridcomputing.com>, linux-ide@vger.kernel.org
Subject: 2.6.20-rc2: known unfixed regressions
Message-ID: <20061228223909.GK20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : PCI_MULTITHREAD_PROBE breakage
References : http://lkml.org/lkml/2006/12/12/21
Submitter  : Ben Castricum <mail0612@bencastricum.nl>
Caused-By  : Greg Kroah-Hartman <gregkh@suse.de>
             commit 009af1ff78bfc30b9a27807dd0207fc32848218a
Status     : known to break many drivers; revert?


Subject    : Acer Extensa 3002 WLMi: 'shutdown -h now' reboots the system
References : http://lkml.org/lkml/2006/12/25/40
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
Status     : unknown


Subject    : i386: Oops in __find_get_block()
References : http://lkml.org/lkml/2006/12/16/138
Submitter  : Ben Collins <ben.collins@ubuntu.com>
             Daniel Holbach <daniel.holbach@ubuntu.com>
Status     : unknown


Subject    : ftp: get or put stops during file-transfer
References : http://lkml.org/lkml/2006/12/16/174
Submitter  : Komuro <komurojun-mbn@nifty.com>
Status     : unknown


Subject    : forcedeth.c 0.59: problem with sideband managment
References : http://bugzilla.kernel.org/show_bug.cgi?id=7684
Submitter  : Michael Reske <micha@gmx.com>
Handled-By : Ayaz Abdulla <aabdulla@nvidia.com>
Status     : problem is being debugged


Subject    : x86_64 boot failure: "IO-APIC + timer doesn't work"
References : http://lkml.org/lkml/2006/12/16/101
Submitter  : Tobias Diedrich <ranma+kernel@tdiedrich.de>
Caused-By  : Andi Kleen <ak@suse.de>
             commit b026872601976f666bae77b609dc490d1834bf77
Handled-By : Yinghai Lu <yinghai.lu@amd.com>
             "Eric W. Biederman" <ebiederm@xmission.com>
Status     : problem is being debugged


Subject    : kernel panics on boot (libata-sff)
References : http://lkml.org/lkml/2006/12/3/99
             http://lkml.org/lkml/2006/12/14/153
             http://lkml.org/lkml/2006/12/24/33
Submitter  : Alessandro Suardi <alessandro.suardi@gmail.com>
Caused-By  : Alan Cox <alan@lxorguk.ukuu.org.uk>
             commit 368c73d4f689dae0807d0a2aa74c61fd2b9b075f
Handled-By : Alan Cox <alan@lxorguk.ukuu.org.uk>
             Steve Wise <swise@opengridcomputing.com>
             Alessandro Suardi <alessandro.suardi@gmail.com>
Status     : people are working on a fix


