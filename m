Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269946AbUJNIBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269946AbUJNIBm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 04:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269994AbUJNIBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 04:01:42 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:64607 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269946AbUJNIBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 04:01:40 -0400
Message-ID: <416E2B6F.5040803@yahoo.com.au>
Date: Thu, 14 Oct 2004 17:31:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
References: <20041013054452.GB1618@frodo> <20041012231945.2aff9a00.akpm@osdl.org> <20041013063955.GA2079@frodo> <20041013000206.680132ad.akpm@osdl.org> <20041013172352.B4917536@wobbly.melbourne.sgi.com> <416CE423.3000607@cyberone.com.au> <20041013013941.49693816.akpm@osdl.org> <20041014005300.GA716@frodo> <20041013202041.2e7066af.akpm@osdl.org> <20041014071659.GB1768@frodo>
In-Reply-To: <20041014071659.GB1768@frodo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> On Wed, Oct 13, 2004 at 08:20:41PM -0700, Andrew Morton wrote:
> 
>>Nathan Scott <nathans@sgi.com> wrote:
>>
>>> I just tried switching CONFIG_HIGHMEM off, and so running the
>>> machine with 512MB; then adjusted the test to write 256M into
>>> the page cache, again in 1K sequential chunks.  A similar mis-
>>> behaviour happens, though the numbers are slightly better (up
>>> from ~4 to ~6.5MB/sec).  Both ext2 and xfs see this.  When I
>>> drop the file size down to 128M with this kernel, I see good
>>> results again (as we'd expect).
>>
>>No such problem here, with
>>
>>	dd if=/dev/zero of=x bs=1k count=128k
>>
>>on a 256MB machine.  xfs and ext2.
> 
> 
> Yup, rebooted with mem=128M and on my box, & that crawls.
> Maybe its just this old hunk 'o junk, I suppose; odd that
> 2.6.8 was OK with this though.
> 

Just out of interest, can you get profiles and a few lines
of vmstat 1 from 2.6.8 and 2.6.9-rc, please?
