Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269200AbUJQRKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbUJQRKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269205AbUJQRKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:10:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26254 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269200AbUJQRKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:10:45 -0400
Date: Sun, 17 Oct 2004 19:12:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Sven Dietrich <sdietrich@mvista.com>, Daniel Walker <dwalker@mvista.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       abatyrshin@ru.mvista.com, amakarov@ru.mvista.com, emints@ru.mvista.com,
       ext-rt-dev@mvista.com, hzhang@ch.mvista.com, yyang@ch.mvista.com,
       "Witold. Jaworski@Unibw-Muenchen. De" 
	<witold.jaworski@unibw-muenchen.de>,
       arnd.heursch@unibw-muenchen.de
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041017171209.GA27341@elte.hu>
References: <20041011215420.GA19796@elte.hu> <EOEGJOIIAIGENMKBPIAECEIEDKAA.sdietrich@mvista.com> <20041012055029.GB1479@elte.hu> <20041014050905.GA6927@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014050905.GA6927@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dipankar Sarma <dipankar@in.ibm.com> wrote:

> It seems that way to me too. Long ago I implemented preemptible RCU,
> but did not follow it through because I believed it was not a good
> idea. The original patch is here :
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0205.1/0026.html
> 
> This allows read-side critical sections of RCU to be preempted. It
> will take a bit of work to re-use it in RCU as of now, but I don't
> think it makes sense to do so. My primary concern is DoS/OOM situation
> due to preempted tasks holding up RCU.

the DoS/OOM problems are serious i believe. Preemptible RCU in that
sense is 'RCU with no guarantee of progress', which sounds bad from a
design POV.

	Ingo
