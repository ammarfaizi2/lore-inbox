Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVA0CSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVA0CSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVAZXnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:43:21 -0500
Received: from mail.joq.us ([67.65.12.105]:40412 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261805AbVAZSzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:55:54 -0500
To: hihone@bigpond.net.au
Cc: Ingo Molnar <mingo@elte.hu>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>
Subject: Re: [ck] [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU feature, -D7
References: <87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
	<87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu>
	<20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu>
	<41F6C5CE.9050303@bigpond.net.au> <41F6C797.80403@bigpond.net.au>
	<20050126100846.GB8720@elte.hu> <41F7C2CA.2080107@bigpond.net.au>
	<87acqwnnx1.fsf@sulphur.joq.us> <41F7DA1B.5060806@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Wed, 26 Jan 2005 12:57:28 -0600
In-Reply-To: <41F7DA1B.5060806@bigpond.net.au> (Cal's message of "Thu, 27
 Jan 2005 04:57:47 +1100")
Message-ID: <87vf9km31j.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal <hihone@bigpond.net.au> writes:

> Jack O'Quin wrote:
>> I notice that JACK's call to mlockall() is failing.  This is one
>> difference between your system and mine (plus, my machine is UP).
>> As an experiment, you might try testing with `ulimit -l unlimited'.
>
> I went for the panic retraction on the first report when I saw the
> failures in the log.  With ulimit -l unlimited, jack seems
> happier. Before the change, ulimit -l showed 32.
>
> At what feels like approaching the end of the run, it still goes clunk
> totally so, dead and gone!
>
> <http://www.graggrag.com/200501270420-oops/>
>
> I'll re-read the mails that have gone by, and think about the next step.

You seem to have eliminated the mlock() failure as the cause of this
crash.  It should not have caused it anyway, but it *was* one
noticeable difference between your tests and mine.  Since
do_page_fault() appears in the backtrace, that is useful to know.

The other big difference is SMP.  What happens if you build a UP
kernel and run it on your SMP machine?
-- 
  joq
