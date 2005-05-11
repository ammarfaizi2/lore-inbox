Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVEKHNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVEKHNo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVEKHMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:12:30 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:51083 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261906AbVEKHKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:10:36 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [Fastboot] Fw: Re: kexec?
From: Alexander Nyberg <alexn@telia.com>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       fastboot@lists.osdl.org, rddunlap@osdl.org, Ralf.Hildebrandt@charite.de,
       petkov@uni-muenster.de, Morton Andrew Morton <akpm@osdl.org>,
       coywolf@gmail.com
In-Reply-To: <20050511030201.GA3799@in.ibm.com>
References: <20050510193225.53192aad.akpm@osdl.org>
	 <20050511030201.GA3799@in.ibm.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 09:10:27 +0200
Message-Id: <1115795427.917.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I've been doing some kexec tests (as described in Documentation/kdump.txt) too
> > > but can't get to load the image and get similar error messages. Let me know
> > > if you need more info about the hardware. The first_kernel was booted with
> > > "crashkernel=64M@16M" and the 16M value was configured into the second during
> > > kconfig in "Physical address where the kernel is loaded" as 0x1000000.
> > > 
> > > [root@zmei]: kexec -p vmlinux --args-linux --append="root=/dev/hda1 maxcpus=1
> > > init 1"
> > 
> >  kexec-tools-1.101 loads for me, but if cmdline is used, it hangs up
> > after "Starting new kernel"
> 
> maxcpus=1 is the culprit. Even through bios/grub kernel does not boot with 
> option maxcpus=1. It is a known issue with got notieced 2.6.12-rc2-mm1 onwards. 
> So build second kernel as uniprocessor kernel and don't specify maxcpus=1 and 
> test it out. It should work.
> 

Vivek,

kexec-tools-1.101 does not contain your last patch series (that includes
--crashdump which is lacking from the above cmdline). Currently you need
to patch up 1.101 with the stuff from 
[RFC/PATCH 5/17][kexec-tools-1.101] Add command line option
"--crash-dump" etc.

It would be good having a 1.2 or something with the patches included on
the site...

