Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263570AbTKQQhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 11:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTKQQg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 11:36:59 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:39900 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263570AbTKQQgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 11:36:55 -0500
Message-ID: <3FB8F910.6080000@BitWagon.com>
Date: Mon, 17 Nov 2003 08:36:32 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: peter@mysql.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Measuring per thread CPU consumption & others statistics for
  NPTL
References: <SxNf.4R.13@gated-at.bofh.it> <SFro.3ee.13@gated-at.bofh.it> <SNSi.6vN.39@gated-at.bofh.it>
In-Reply-To: <SNSi.6vN.39@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> On Mon, 2003-11-17 at 03:27, Peter Chubb wrote:
>>If you apply my microstate accounting patch, you can get nanosecomnd
>>resolution per thread.
> 
> Is it planned to be included in the kernel at some point ?
> For me it is the most important not to get things working on some
> particular test systems, but to allow customers, which run generic or
> vendor provided kernels to use the functionality.

The current 2.6.0-test9-bk22 has no microsecond-or-finer per-thread
accounting, so based on current policy and past experience you may
have to wait two years.

A leading contender for x86 and x86_64 is the perfctr patches
http://www.csd.uu.se/~mikpe/linux/perfctr/  which have been maintained
for a number of years (v1.0 at 2000-01-31 for Linux 2.2.14/2.3.41) and
have a following, including  http://icl.cs.utk.edu/projects/papi/ .
A recent patched, ready-to-install NPTL kernel happens to reside at
http://www.BitWagon.com/ftp/kernel-smp-2.4.20-20.9.perfctr2.5.5.i686.rpm .

For a complete profiler:  http://www.BitWagon.com/tsprof/tsprof.html
which also will run on a generic kernel in "-wallclock" mode
(TSC cycle accuracy, but not virtualized.)

-- 



