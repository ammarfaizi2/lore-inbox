Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUBIGzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 01:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbUBIGzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 01:55:20 -0500
Received: from ns.suse.de ([195.135.220.2]:11243 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264919AbUBIGzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 01:55:15 -0500
Date: Tue, 10 Feb 2004 14:32:08 +0100
From: Andi Kleen <ak@suse.de>
To: lepton <lepton@sina.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
Message-Id: <20040210143208.7b1d9940.ak@suse.de>
In-Reply-To: <20040209035356.GA27697@lepton.goldenhope.com.cn>
References: <20040208143740.GA25010@lepton.goldenhope.com.cn.suse.lists.linux.kernel>
	<p73y8rdk3ng.fsf@verdi.suse.de>
	<20040209035356.GA27697@lepton.goldenhope.com.cn>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004 11:53:56 +0800
lepton <lepton@sina.com> wrote:

> If I disabled "Node Memory Interleave" setting in BIOS. The kernel will
> boot. It saids It could't find numa configuration.But the scsi disk is
> unusable after boot.File system on scsi disk can not be mounted. The kernel
> complain about some file system error.
> 
> If I set "Node Memoey Interleave" to "Auto",the kernel will panic in the
> init process of scsi.

And it boots with numa=off ? 

> Another problem perhaps has no relation with this problem is that the
> system won't reboot automatic after panic although I have set panic=1
> in boot.

Try reboot=bios or reboot=triple
 
> The scsi card I am using is a Adaptec SCSI Card 29160LP.
> 
> I have tested linux kernel-2.6.1/2.6.2, all of them has no such problem.

Compiled with NUMA on I suppose? 

> Others has use United Linux in the server serveral moths ago.I know the 
> kernel comes with the distrbution (2.4.19) works fine too.

The original UnitedLinux install didn't default to NUMA, unless
you installed the special k_numa kernel. Later SPs did.
If you used an NUMA kernel can you please check which kernel 
revision (between 2.4.20 and 2.4.24) broke it?

> 
> Bootdata ok (command line is ro root=/dev/hda2 console=ttyS0,19200 panic=1)
> Linux version 2.4.24 (root@amd64.ytht.net) (gcc version 3.3.2 20030908 (Debian prerelease)) #1 SMP Mon Feb 9 02:01:47 UTC 2004

I'm a bit suspicious of this compiler. Any chance you could try it with a gcc 3.2 too? 

[...]

The boot output for the NUMA scanning looks ok, I cannot see what's wrong with it.

-Andi
