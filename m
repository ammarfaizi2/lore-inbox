Return-Path: <linux-kernel-owner+w=401wt.eu-S1751902AbWLNK07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbWLNK07 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWLNK07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:26:59 -0500
Received: from web59212.mail.re1.yahoo.com ([66.196.101.38]:27915 "HELO
	web59212.mail.re1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751902AbWLNK06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:26:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ZgjF/773PTox71o55vBkBPqHl+Q9/jNrJslXLp8GaB2hp4dzCQ4vw2pNCGE9qQNVjeQBXf2I5Jal6nsuCWwg72amuyEIBxtszTPLL080HHsm3/grDMLJ9sz8za0xJP/9dZwaSsw3017r2PN6McrZLUQE9x7KIjy34zCMIVPQA8k=;
X-YMail-OSG: Er_MzYwVM1mxhIP0ZYX9aMISu1GDrLzJSJvUTomI
Date: Thu, 14 Dec 2006 02:26:56 -0800 (PST)
From: tike64 <tike64@yahoo.com>
Subject: Re: realtime-preempt and arm
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20061214100055.GB19549@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <297400.29698.qm@web59212.mail.re1.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
> tike64 <tike64@yahoo.com> wrote:
> > Ok, understood; I tried this:
> > 
> > 	t = raw_timer();
> > 	ts.tv_nsec = 5000000;
> > 	ts.tv_sec = 0;
> > 	nanosleep(&ts, 0);
> > 	t = raw_timer() - t;
> > 
> > It is better but I still see 8ms occasional delays when listing 
> > nfs-mounted directories onto FB. And, what is funny, also this
> > version makes the average delay 20ms as if it made the jiffy 20ms.
> 
> ARM has no high resolution timers support yet in the -rt tree.

Yes, but is there a reason why the -rt patch seems to make the 10ms
jiffy 20ms and why the jitter is so high. I don't need high resolution
but reasonable, a couple of milliseconds, jitter.

--

tike



 
____________________________________________________________________________________
Cheap talk?
Check out Yahoo! Messenger's low PC-to-Phone call rates.
http://voice.yahoo.com
