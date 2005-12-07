Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbVLGKef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbVLGKef (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVLGKef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:34:35 -0500
Received: from ext-gw.newtoncomputing.co.uk ([81.2.122.18]:520 "EHLO
	mail.newtoncomputing.co.uk") by vger.kernel.org with ESMTP
	id S1750822AbVLGKee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:34:34 -0500
Date: Wed, 7 Dec 2005 10:34:27 +0000
From: matthew-lkml@newtoncomputing.co.uk
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.27 crashed: any ideas?
Message-ID: <20051207103427.GB6542@newtoncomputing.co.uk>
References: <20051206111625.GA6542@newtoncomputing.co.uk> <Pine.LNX.4.64.0512060944480.13220@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512060944480.13220@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.9i
X-NC-Fw-Sig: 579b9f15cc6d6ef038f7c9571346d6bf matthew-lkml@newtoncomputing.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 06, 2005 at 09:47:34AM -0800, Zwane Mwaikambo wrote:
> On Tue, 6 Dec 2005, matthew-lkml@newtoncomputing.co.uk wrote:
> > Our main user-facing Linux machine at work crashed a couple of times over the
> > last few days, both with the same error. It's been up and stable for the last
> > 80ish days (from when it was upgraded to Debian sarge), and had no problems
> > before that with the same kernel.
> > 
> > Machine is an HP DL740 with four Xeon 2Ghz CPUs and 4Gb RAM (5Gb RAID 5).
> > 
> > I've put both outputs that our console logger saved, and the result from running
> > them through ksymoops, at http://www.le.ac.uk/cc/mcn4/problem/
> > 
> > I realise the kernel is tainted. It's a locally compiled Debian kernel. I think
> > the non-free module is the qla SAN card driver, but I'm not sure (is there a way
> > of finding out what exactly tainted the kernel?)
> > 
> > The strange thing is that both times it seemed to crash in cfi_probe, which
> > looks like something to do with Compact Flash / MTDs. Something we don't use.
> 
> You're probably using a bad System.map, all we do know is that the oops is 
> occuring in a module. Can you try rerunning ksymoops using the System.map 
> in your kernel build directory? Or, cat /proc/modules before it oopses and 
> then we can compare the faulting address.

Thanks for the ideas from different people. I've started to take a copy of
/proc/modules and /proc/ksyms on an every-two-minutes basis, so should have the
latest versions if it goes down again. I hadn't realised that things change
depending on the module load order. (Are there any other things from the running
system I should backup in case of a crash?)

I'm considering going to a later kernel, as it's been pointed out that this
version is quite old. It is that version because it is a recompiled Debian one
with a couple of additional patches (like QLogic qla2x000 support). Hence why I
posted here not the Debian lists...

I'll ignore the Debian kernel next anyway if I go to 2.6, as they've annoyingly
stripped the qla modules out. Ho hum.

Of course, it hasn't crashed again yet. I'm still waiting to see, as I'd like to
find out what is causing it!

Thanks!

-- 
Matthew
