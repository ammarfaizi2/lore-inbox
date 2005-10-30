Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVJ3Qak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVJ3Qak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVJ3Qak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:30:40 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:38620 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751059AbVJ3Qaj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:30:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UyAW8YNOioBdYi41EkXuzZG90vgi7Kbt7bNj9NGpUgc4SNhbEtg9YWn/ehUCBzTCvdEm6HExla1y75ajBo3DXSLLdptrcxnO5Sfnyma/ggbIkMEfZmGZ+9ELuvd2EeUVGXhxkgEARECbOoEz3awZaEAsEtcb94+MnkQ0N+mP/rk=
Message-ID: <5bdc1c8b0510300830p7a8690b0h5581835502e88093@mail.gmail.com>
Date: Sun, 30 Oct 2005 08:30:38 -0800
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rt1
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20051030133316.GA11225@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/05, Ingo Molnar <mingo@elte.hu> wrote:
>
> i have released the 2.6.14-rt1 tree, which can be downloaded from the
> usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>
> this release is mainly about ktimer fixes: it updates to the latest
> ktimer tree from Thomas Gleixner (which includes John Stultz's latest
> GTOD tree), it fixes TSC synchronization problems on HT systems, and
> updates the ktimers debugging code.
>
> These together could fix most of the timer warnings and annoyances
> reported for 2.6.14-rc5-rt kernels. In particular the new
> TSC-synchronization code could fix SMP systems: the upstream TSC
> synchronization method is fine for 1 usec resolution, but it was not
> good enough for 1 nsec resolution and likely caused the SMP bugs
> reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
>
> Please re-report any bugs that remain.
>
> Changes since 2.6.14-rc5-rt1:
>
>  - GTOD -B9 (John Stultz)
>
>  - ktimer updates (Thomas Gleixner, me)

I am no longer seeing any ktimer messages in dmesg after booting. So
far so good.

>
>  - ktimer debugging check fixes (Steven Rostedt)
>
>  - smarter TSC synchronization on SMP - we now rely on it for nsecs (me)
>
>  - x64 build fix (reported by Mark Knecht)

Thanks Ingo. This seems fixed. 2.6.14-rt1 up and running here.

>
>  - tracing fix (reported by Florian Schmidt)
>
>  - rtc histogram fixes (K.R. Foley)
>
>  - merge to 2.6.14
>
> to build a 2.6.14-rt1 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.14-rt1
>
>         Ingo
>

Cheers,
Mark
