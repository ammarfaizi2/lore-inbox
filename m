Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266810AbUIIXVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266810AbUIIXVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUIIXVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:21:50 -0400
Received: from holomorphy.com ([207.189.100.168]:26804 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266810AbUIIXVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:21:03 -0400
Date: Thu, 9 Sep 2004 16:20:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rlrevell@joe-job.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
       Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040909232053.GP3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, rlrevell@joe-job.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	felipe_alfaro@linuxmail.org, mista.tapas@gmx.net, kr@cybsft.com,
	Mark_H_Johnson@Raytheon.com
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu> <1094626562.1362.99.camel@krustophenia.net> <20040909192924.GA1672@elte.hu> <20040909130526.2b015999.akpm@osdl.org> <20040909224535.GN3106@holomorphy.com> <1094767887.15731.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094767887.15731.0.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-09 at 23:45, William Lee Irwin III wrote:
>> Something odd is going on, in part because I get *blistering* IO speeds
>> running benchmarks like dbench, tiobench, et al on tmpfs with striped
>> swap. In fact, IO speeds markedly faster than any other filesystem I've
>> ever tried, by about 30MB/s (i.e. wirespeed, where others fall about
>> 37.5% short of it). Virtual alignment issues do hurt, but the core
>> allocation algorithm appears to be better than good, it's astounding.

On Thu, Sep 09, 2004 at 11:11:39PM +0100, Alan Cox wrote:
> Thats a very atypical load where you can expect to get long linear write
> outs. The seek v write numbers for a disk nowdays have more in common
> with a tape drive. Paging tends to be much much more random.

Yes, I mentioned that those kinds of benchmarks are not the workload
we're shooting for in the second part of the message. The commentary
regarding dbench et al on tmpfs suggests that the lower-level parts of
the algorithm are sound, but are somehow driven inappropriately or in a
manner unaligned with what locality of reference there may be.


-- wli
