Return-Path: <linux-kernel-owner+w=401wt.eu-S1751667AbWLWDDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWLWDDp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 22:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbWLWDDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 22:03:45 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:37605 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbWLWDDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 22:03:44 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 22:03:44 EST
From: John A Chaves <chaves@computer.org>
To: Christoph Anton Mitterer <calestyo@scientia.net>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Date: Fri, 22 Dec 2006 20:56:39 -0600
User-Agent: KMail/1.9.5
Cc: Karsten Weiss <K.Weiss@science-computing.de>, Chris Wedgwood <cw@f00f.org>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>, muli@il.ibm.com
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de> <458C8EBE.3010506@scientia.net>
In-Reply-To: <458C8EBE.3010506@scientia.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612222056.39939.chaves@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 December 2006 20:04, Christoph Anton Mitterer wrote:
> This brings me to:
> Chris Wedgwood wrote:
> > Does anyone have an amd64 with an nforce4 chipset and >4GB that does
> > NOT have this problem? If so it might be worth chasing the BIOS
> > vendors to see what errata they are dealing with.
> John Chaves replied and claimed that he wouldn't suffer from that
> problem (I've CC'ed him to this post).
> You can read his message at the bottom of this post.
> @ John: Could you please tell us in detail how you've tested your system?

I didn't need to run a specific test for this.  The normal workload of the
machine approximates a continuous selftest for almost the last year.

Large files (4-12GB is typical) are being continuously packed and unpacked
with gzip and bzip2.  Statistical analysis of the datasets is followed by
verification of the data, sometimes using diff, or md5sum, or python
scripts using numarray to mmap 2GB chunks at a time.  The machine
often goes for days with a load level of 20+ and 32GB RAM + another 32GB
swap in use.  It would be very unlikely for data corruption to go unnoticed.

When I first got the machine I did have some problems with disks being
dropped from the RAID and occasional log messages implicating the IOMMU.
But that was with kernel 2.6.16.?, Kernels since 2.6.17 haven't had any
problem.

John
