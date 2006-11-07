Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753711AbWKGNa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbWKGNa1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbWKGNa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:30:27 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9485 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753734AbWKGNaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:30:25 -0500
Date: Tue, 7 Nov 2006 14:30:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ernst Herzberg <earny@net4u.de>, Len Brown <len.brown@intel.com>,
       mingo@redhat.com, Martin Lorenz <martin@lorenz.eu.org>, pavel@suse.cz,
       linux-pm@osdl.org, linux-acpi@vger.kernel.org,
       Paolo Ornati <ornati@fastwebnet.it>,
       Thierry Vignaud <tvignaud@mandriva.com>, jgarzik@pobox.com,
       linux-ide@vger.kernel.org, Alex Romosan <romosan@sycorax.lbl.gov>,
       Jens Axboe <jens.axboe@oracle.com>,
       Prakash Punnoor <prakash@punnoor.de>, phil.el@wanadoo.fr,
       oprofile-list@lists.sourceforge.net, ak@suse.de, discuss@x86-64.org,
       Tim Chen <tim.c.chen@linux.intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Chua <jeff.chua.linux@gmail.com>, gregkh@suse.de,
       linux-pci@atrey.karlin.mff.cuni.cz, Komuro <komurojun-mbn@nifty.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Bryan O'Sullivan" <bos@serpentine.com>, openib-general@openib.org,
       Arjan van de Ven <arjan@linux.intel.com>,
       Shaohua Li <shaohua.li@intel.com>, tigran@veritas.com
Subject: 2.6.19-rc4: known unfixed regressions (v4)
Message-ID: <20061107133025.GF8099@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This email lists some known regressions in 2.6.19-rc compared to 2.6.18
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : ThinkPad R50p: boot fail with (lapic && on_battery)
References : http://lkml.org/lkml/2006/10/31/333
Submitter  : Ernst Herzberg <earny@net4u.de>
Handled-By : Len Brown <len.brown@intel.com>
Status     : problem is being debugged


Subject    : ThinkPad T60: no screen after resume
References : http://mail.matrix.de/pipermail/linux-thinkpad/2006-November/037011.html
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : unknown


Subject    : ThinkPad T60: lose ACPI events after suspend/resume
References : http://lkml.org/lkml/2006/10/10/39
             http://bugzilla.kernel.org/show_bug.cgi?id=7408
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : problem might be fixed by
             commit f9dadfa71bc594df09044da61d1c72701121d802


Subject    : i386: more DWARFs and strange messages
References : http://lkml.org/lkml/2006/10/29/127
Submitter  : Martin Lorenz <martin@lorenz.eu.org>
Status     : should be fixed by
             commit 4b96b1a10cb00c867103b21f0f2a6c91b705db11


Subject    : BUG: scheduling while atomic: events/0/0x00000001/4, etc..
References : http://lkml.org/lkml/2006/11/2/209
Submitter  : Paolo Ornati <ornati@fastwebnet.it>
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : unable to rip cd
References : http://lkml.org/lkml/2006/10/13/100
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Status     : unknown


Subject    : x86_64: oprofile doesn't work
References : http://lkml.org/lkml/2006/10/27/3
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : x86_64: NR_IRQ increase causes 11.5% slowdown
                     in lmbench's fork benchmark
References : http://lkml.org/lkml/2006/11/2/192
Submitter  : Tim Chen <tim.c.chen@linux.intel.com>
Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
             commit 550f2299ac8ffaba943cf211380d3a8d3fa75301
Status     : unknown


Subject    : PCI: MMCONFIG breakage
References : http://lkml.org/lkml/2006/10/27/251
Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
Handled-By : Andi Kleen <ak@suse.de>
Status     : Andi is investigating, both BIOS and Direct work


Subject    : SMP kernel can not generate ISA irq properly
References : http://lkml.org/lkml/2006/10/22/15
Submitter  : Komuro <komurojun-mbn@nifty.com>
Handled-By : Thomas Gleixner <tglx@linutronix.de>
Status     : Thomas is investigating


Subject    : ipath driver MCEs system on load when HT chip present
References : http://bugzilla.kernel.org/show_bug.cgi?id=7455
Submitter  : Bryan O'Sullivan <bos@serpentine.com>
Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
Handled-By : Bryan O'Sullivan <bos@serpentine.com>
             Eric W. Biederman <ebiederm@xmission.com>
Status     : Bryan and Eric are working on fixing the ipath driver


Subject    : boot hang in the microcode driver
References : http://lkml.org/lkml/2006/11/6/117
Submitter  : Arjan van de Ven <arjan@linux.intel.com>
Caused-By  : Shaohua Li <shaohua.li@intel.com>
             commit a30a6a2cb0fdc2c9701d6ddfb21affeb8146c038
Handled-By : Arjan van de Ven <arjan@linux.intel.com>
Patch      : http://lkml.org/lkml/2006/11/6/117
Status     : workaround-patch available


