Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267211AbUG1PLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUG1PLB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUG1PLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:11:01 -0400
Received: from pD95177F3.dip.t-dialin.net ([217.81.119.243]:22661 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267211AbUG1PJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:09:52 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040728142649.GB29893@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
	 <1090968457.743.3.camel@mindpipe> <20040728050535.GA14742@elte.hu>
	 <1091015060.5560.9.camel@localhost>  <20040728142649.GB29893@elte.hu>
Content-Type: text/plain
Message-Id: <1091027297.7939.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 17:08:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> * Thomas Charbonnel <thomas@undata.org> wrote:
> 
> > The other source of xrun was seen during the disk write tests, once
> > the memory runs out (spikes up to 14 ms, but more generally 6 ms)
> 
> which particular filesystem and disk driver are you using? (ext3/IDE?) 
> The 'disk write tests' are those of latencytest-0.5.4?
> 
> 	Ingo

It's an IDE reiserfs disk.
Those are indeed the disk write tests from latencytest-0.5.4
My mistake about the spikes, they are more 3 ms than 6.
You can see the results here :
http://www.undata.org/~thomas/latencytest-0.5.4/rtc_freq_2048/
http://www.undata.org/~thomas/latencytest-0.5.4/rtc_freq_4096/
http://www.undata.org/~thomas/latencytest-0.5.4/rtc_freq_8192/

The traces always look the same : 

T=29.6014 diff=14.4758
 rtc_interrupt (+bd)
 handle_IRQ_event (+50)
 do_hardirq (+bc)
 irqd (+ac)
 kthread (+aa)
 irqd (+0)
 kthread (+0)
 kernel_thread_helper (+5)


Thomas


