Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265847AbUG1GSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUG1GSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 02:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266183AbUG1GSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 02:18:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:37285 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265847AbUG1GSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 02:18:21 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-L2, preemptable hardirqs
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
In-Reply-To: <20040728045916.GA14474@elte.hu>
References: <1090732537.738.2.camel@mindpipe>
	 <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040727162759.GA32548@elte.hu>
	 <1090969026.743.12.camel@mindpipe>  <20040728045916.GA14474@elte.hu>
Content-Type: text/plain
Message-Id: <1090995519.747.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 02:18:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 00:59, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > The obvious next feature to add would be to make certain IRQs
> > non-schedulable, like you would for an RT system.  For an audio system
> > this would be just the soundcard interrupt (and timer as stated
> > above).  Then, while it still might not be hard-RT, it would blow away
> > anything achievable on the other OS'es people do audio work with.
> 
> yes, this is the next step. Does v=3 work on your system? (even if the
> delaying of the soundcard irq causes latencies.)
> 

Yes, it works well, except for this behavior which is as expected.  I
will test making this interrupt 'direct' tomorrow, it is not shared with
anything too heavy.

Lee



