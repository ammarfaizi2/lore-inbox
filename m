Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRKSPWy>; Mon, 19 Nov 2001 10:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279454AbRKSPWr>; Mon, 19 Nov 2001 10:22:47 -0500
Received: from hq2.fsmlabs.com ([209.155.42.199]:30483 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S279317AbRKSPVy>;
	Mon, 19 Nov 2001 10:21:54 -0500
Date: Mon, 19 Nov 2001 08:15:43 -0700
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, lse-tech@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Real Time Runqueue
Message-ID: <20011119081543.A27011@hq2>
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com> <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com>
User-Agent: Mutt/1.3.23i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 04:32:24PM -0800, Mike Kravetz wrote:
> The reason I ask is that we went through the pains of a separate
> realtime RQ in our MQ scheduler.  And yes, it does hurt the common
> case, not to mention the extra/complex code paths.  I was hoping
> that someone in the know could enlighten us as to how RT semantics
> apply to SMP systems.  If the semantics I suggest above are required,
> then it implies support must be added to any possible future
> scheduler implementations.

POSIX RT specs, at least last year, did not mention any SMP
requirements for scheduling at all.
What we do in RTLinux is require that RT threads be associated with a
processor identifier on the theory that the user may have some idea what
processors should run which RT threads, but the OS has no way of
guessing.




> 
> -- 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
