Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWITTi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWITTi5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWITTi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:38:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:51242 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932316AbWITTi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:38:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ER34BcOIa9MFSlpdczrn+e+VGaLltgLam108mVfVO0derYhT4gPecwjKF5FtTayBxRPlwJ+q8vvIjFA/687Nw3OYc4vSMfjSoHo1kRfTk7mKpzIsSrEJNAxLagjDLJWnG0FRVErJi737/iBH/GAqAFywaJmW0DhCJ1K0SsEyFKI=
Message-ID: <5bdc1c8b0609201238te67affcne7bb21d50bda3a69@mail.gmail.com>
Date: Wed, 20 Sep 2006 12:38:55 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rt1
Cc: linux-kernel@vger.kernel.org, "Thomas Gleixner" <tglx@linutronix.de>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Dipankar Sarma" <dipankar@in.ibm.com>,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060920141907.GA30765@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060920141907.GA30765@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/06, Ingo Molnar <mingo@elte.hu> wrote:
> I'm pleased to announce the 2.6.18-rt1 tree, which can be downloaded
> from the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

Hi Ingo,
   I gave 2.6.18-rt2 a quick try. It compiled fine but crashed on
boot. I've no way to copy the screen. I can send along a digital photo
if the following isn't enough info.

QUESTION: Should I be able to run ati-drivers-8.28.8 with this kernel
or would I have to wait for ATI to put out a 2.6.18 compatible driver?
The current version does not emerge with 2.6.18-rt2.

CRASH INFO:

Unable to handle kernel null pointer derefernce at 0000000000000000 RIP
[< ffffffff80228ae4 >] __wake_up_common+0x24/0x68
PGD 3d6e7067 PUD 3d638067 PMD 0
Oops: 0000 [1] PREEMPT SMP
CPU
Modules linked in:
Pid: 5, comm:softirq-timer/0 Not tainted 2.6.18-rt2 #2

There is a bunch of debug stuff that follows and then finally a trace:

__wake_up
hrt_time_run_queue
run_timer_softirq
kthread
child_rip
DWARF2 unwinder stuck at child_rip

more stuff......

preempt count: 00000001
1-level deep critical nesting:

__spin_trylock


Not sure how much that will help you. Been awhile since I've sent
along crash reports. I'll have to ge a second Linux machine running to
do the console boot capture thing if you need it.

Hope this helps,
Mark
