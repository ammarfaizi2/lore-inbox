Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbVKDHFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVKDHFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 02:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbVKDHFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 02:05:40 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:7873 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S1751411AbVKDHFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 02:05:39 -0500
Subject: Re: 2.6.14-rt1
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20051102070205.GA1348@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu> <20051102070205.GA1348@elte.hu>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 23:04:38 -0800
Message-Id: <1131087878.31198.8.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 08:02 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > The same kernel built for fc3 fails to boot in my Sony laptop. I see 
> > this:
> > 
> > Kernel panic - not syncing: Attempted to kill init!
> 
> why did it panic - no indication of that?

I said no but I did not look close enough. Sorry. 

I tried 2.6.14-rt4 on my laptop and there's no backtrace or anything
like that before the panic, but there was a message from selinux (I
don't have a copy and I'm not on that kernel - something like "no policy
loaded but in enforcing mode"). So I turned selinux off and it booted...

I'm also seeing selinux oddities in my amd smp system, rpm complaining
about things when installing a package:

 line 1574 has invalid context system_u:object_r:spamd_exec_t
/etc/selinux/targeted/contexts/files/file_contexts:  line 1575 has
invalid context system_u:object_r:spamd_exec_t
/etc/selinux/targeted/contexts/files/file_contexts:  line 1576 has
invalid context system_u:object_r:spamd_exec_t

I'll have to investigate a bit more tomorrow if I find the time. 

Booting into previous kernels with the same selinux setup shows no
problems. This is recent, probably started with 2.6.14-rt1.

-- Fernando


