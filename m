Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTAOBIN>; Tue, 14 Jan 2003 20:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbTAOBIN>; Tue, 14 Jan 2003 20:08:13 -0500
Received: from fmr01.intel.com ([192.55.52.18]:31170 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265608AbTAOBHm>;
	Tue, 14 Jan 2003 20:07:42 -0500
Subject: Re: Unable to boot off kernel built on different machine
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Bruce Harada <bharada@coral.ocn.ne.jp>
Cc: rusty@penguin.co.intel.com, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030115100119.6e8e731f.bharada@coral.ocn.ne.jp>
References: <200301141938.h0EJcaO8018734@penguin.co.intel.com> 
	<20030115100119.6e8e731f.bharada@coral.ocn.ne.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Jan 2003 01:15:15 -0800
Message-Id: <1042535719.3360.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I figured it out.  All I had to do was use 'rdev' to set the root 
correctly.  Machine 'A' was setting the root as /dev/hda1 and 
Machine 'B' was setting the root as /dev/hdb1.

The kernel README gave me the clue.

    --rustyl

On Tue, 2003-01-14 at 17:01, Bruce Harada wrote:
> On Tue, 14 Jan 2003 11:38:36 -0800
> Rusty Lynch <rusty@penguin.co.intel.com> wrote:
> 
> > I am having the strange problem (that I suspect is embarrassingly simple)
> > where I can only boot a kernel built on the same machine.  For example
> > my setup looks like:
> > 
> > * machine 'A' (RH 8.0 P4 system): 
> >   - contains a 2.5 kernel tree on an exported NFS drive
> >   - this is the machine where I do all my real work, and
> >     do not want to run test kernels on
> > * machine 'B' (RH 8.0 P3 system):
> >   - mounts the kernel tree on 'A' to make it easy to
> >     install new kernels on for testing
> [SNIP]
> 
> Check /etc/fstab on machines A and B - what do they contain?


