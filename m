Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVGGMX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVGGMX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVGGMST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:18:19 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:22742 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S261303AbVGGMPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:15:24 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Thu, 7 Jul 2005 13:15:24 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507071237.42470.s0348365@sms.ed.ac.uk> <20050707114223.GA29825@elte.hu>
In-Reply-To: <20050707114223.GA29825@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071315.24669.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 Jul 2005 12:42, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > do you have DEBUG_STACKOVERFLOW and latency tracing still enabled?  The
> > > combination of those two options is pretty good at detecting stack
> > > overflows. Also, you might want to enable CONFIG_4KSTACKS, that too
> > > disturbs the stack layout enough so that the error message may make it
> > > to the console.
> >
> > I already have 4KSTACKS on. Latency tracing is enabled, but
> > STACKOVERFLOW isn't; I'll just reenable everything again until we fix
> > this. Do you think if I removed the printk() line I might get some
> > useful information, before it does the stack trace?
>
> usually such loops happen if the stack has been overflown and critical
> information that lies on the bottom of the stack (struct thread_info) is
> overwritten. Then we often cannot even perform simple printks. Stack
> overflow debugging wont prevent the crash, but might give a better
> traceback.
>
> 	Ingo

http://devzero.co.uk/~alistair/oops1.jpeg

I disabled the trace and the STACKOVERFLOW option seems to help; I've got a 
(slightly truncated) oops from the kernel. What happens is that I get an 
oops, then I get a BUG: warning me about the softlock, then I get another 
oops. I'm about to reboot to confirm whether the second oops is identical to 
the first (I suspect that it is).

Is this any help do you?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
