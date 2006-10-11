Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbWJKSir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWJKSir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965078AbWJKSir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:38:47 -0400
Received: from nsm.pl ([195.34.211.229]:28189 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S965056AbWJKSiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:38:46 -0400
Date: Wed, 11 Oct 2006 20:38:31 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Christian <christiand59@web.de>
Cc: "Langsdorf, Mark" <mark.langsdorf@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: cpufreq not working on AMD K8 (was Re: 2.6.19-rc1: known regressions)
Message-ID: <20061011183831.GB9407@irc.pl>
Mail-Followup-To: Christian <christiand59@web.de>,
	"Langsdorf, Mark" <mark.langsdorf@amd.com>,
	linux-kernel@vger.kernel.org
References: <1449F58C868D8D4E9C72945771150BDF1536FD@SAUSEXMB1.amd.com> <200610112016.32158.christiand59@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610112016.32158.christiand59@web.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 08:16:32PM +0200, Christian wrote:
> Am Mittwoch, 11. Oktober 2006 19:33 schrieb Langsdorf, Mark:
> > > It seems that my first try exceeded the LKML size limit. So
> > > hopefully you should get my decompiled DSDT now as a bzip
> > > compressed file.
> >
> > Right then.  You're completely missing the _PCT, _PPC, and
> > _PSS packages, as well as the CPU scope they're normally
> > defined in.  powernow-k8 is not going to work on this system.
> 
> user@ubuntu:~$ uname -a
> Linux ubuntu.localnet 2.6.18-rc7 #2 SMP Wed Sep 13 11:28:41 CEST 2006 x86_64 
> GNU/Linux
> user@ubuntu:~$ dmesg | grep power
> [  402.879894] powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 
> 3800+ processors (version 2.00.00)
> [  402.880409] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x8
> [  402.880412] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0xa
> [  402.880415] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
> [  402.881299] powernow-k8: ph2 null fid transition 0xc
> 
> 2.6.18-rc7 powerfreq works nice. Double checked it!

  There are strange woes with cpufreq in current kernel. During
2.6.18-rc cpufreq-nforce2 was broken, then fixed (acpi-cpufreq was
failing to propagate registration error) then broken again. It still
doesn't work in 19-rc1.

-- 
Tomasz Torcz                Only gods can safely risk perfection,
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

