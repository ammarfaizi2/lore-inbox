Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264098AbUIOJ4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUIOJ4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIOJ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:56:11 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:4358 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S264098AbUIOJ4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:56:04 -0400
Message-ID: <58425.195.245.190.93.1095242005.squirrel@195.245.190.93>
In-Reply-To: <20040915093859.GA1629@elte.hu>
References: <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
    <1094597710.16954.207.camel@krustophenia.net>
    <1094598822.16954.219.camel@krustophenia.net>
    <32930.192.168.1.5.1094601493.squirrel@192.168.1.5>
    <20040908082358.GB680@elte.hu> <20040908083158.GA1611@elte.hu>
    <37312.195.245.190.93.1094728166.squirrel@195.245.190.93>
    <1095210962.2406.79.camel@krustophenia.net>
    <19084.195.245.190.94.1095240596.squirrel@195.245.190.94>
    <20040915093859.GA1629@elte.hu>
Date: Wed, 15 Sep 2004 10:53:25 +0100 (WEST)
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "Florian Schmidt" <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 15 Sep 2004 09:56:03.0582 (UTC) FILETIME=[364709E0:01C49B0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Ingo Molnar wrote:
>
>Rui Nuno Capela wrote:
>
>> b) When CONFIG_SCHED_SMT is not set, I can run all along with
>> softirq-preempt=1, hardirq-preempt=1 et al. While running jackd in
>> realtime mode, I get NO hard-locks, but unfortunately XRUNs are
>> plenty. A real storm. However I've noticed that the whole seems pretty
>> much stable, as I didn't experience one single system hang. Regression
>> to softirq-preempt=0 and hardirq-preempt=0 dissolves the xrun storm to
>> nothing again.
>
> when you set softirq-preempt=1 and hardirq-preempt=1 then you also need
> to make the soundcard's IRQ non-threaded via /proc/irq/*/*/threaded
> (pick the right one that is your soundcard). E.g. i have a CMI8738-MC6
> on IRQ11, so i'd have to do this:
>
> 	echo 0 > /proc/irq/11/CMI8738-MC6/threaded
>
> to mark the soundcard's interrupt as directly-executed.
>

Yes, I didn't mentioned that, but I do have provided it and assumed on all
my reported trials:

    echo 0 > "/proc/irq/8/rtc/threaded"
    echo 0 > "/proc/irq/17/Intel ICH5/threaded"

Thanks.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

