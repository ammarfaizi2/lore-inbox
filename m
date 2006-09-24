Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752046AbWIXB22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbWIXB22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 21:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWIXB22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 21:28:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6614 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752046AbWIXB21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 21:28:27 -0400
Date: Sat, 23 Sep 2006 21:28:21 -0400
From: Dave Jones <davej@redhat.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Subject: Re: New Intel feature flags.
Message-ID: <20060924012821.GA24392@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
References: <20060924011532.GA5804@redhat.com> <6bffcb0e0609231821q28124d7cr4bc4f10965bc043c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0609231821q28124d7cr4bc4f10965bc043c@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 03:21:06AM +0200, Michal Piotrowski wrote:
 > Hi Dave,
 > 
 > On 24/09/06, Dave Jones <davej@redhat.com> wrote:
 > > Add supplemental SSE3 instructions flag, and Direct Cache Access flag.
 > > As described in "Intel Processor idenfication and the CPUID instruction
 > > AP485 Sept 2006"
 > >
 > > Signed-off-by: Dave Jones <davej@redhat.com>
 > >
 > > --- local-git/arch/i386/kernel/cpu/proc.c~      2006-09-23 20:46:35.000000000 -0400
 > > +++ local-git/arch/i386/kernel/cpu/proc.c       2006-09-23 20:48:02.000000000 -0400
 > > @@ -46,8 +46,8 @@ static int show_cpuinfo(struct seq_file
 > >
 > >                 /* Intel-defined (#2) */
 > >                 "pni", NULL, NULL, "monitor", "ds_cpl", "vmx", "smx", "est",
 > > -               "tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
 > > -               NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 > > +               "tm2", "ssse3", "cid", NULL, NULL, "cx16", "xtpr", NULL,
 > 
 > ssse3? Typo?

No. It stands for Supplemental SSE3.  SSE is already indicated by 'pni'.

	Dave
