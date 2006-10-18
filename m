Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161053AbWJROlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161053AbWJROlh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWJROlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:41:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:37818 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161055AbWJROlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:41:36 -0400
Date: Wed, 18 Oct 2006 16:33:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
       mgreer@mvista.com, sshtylyov@ru.mvista.com
Subject: Re: [PATCH -rt] powerpc update
Message-ID: <20061018143318.GB25141@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com> <20061018072858.GA29576@elte.hu> <1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> On Wed, 2006-10-18 at 09:28 +0200, Ingo Molnar wrote:
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> > > Pay close attention to the fasteoi interrupt threading. I added usage 
> > > of mask/unmask instead of using level handling, which worked well on 
> > > PPC.
> > 
> > this is wrong - it should be doing mask+ack.
> 
> The main reason I did it this way is cause the current threaded eoi 
> expected the line to be masked. So if you happen to have a eoi that's 
> threaded you get a warning then the interrupt hangs.

does that in fact happen on -rt6? If yes, could you send the warning 
that is produced?

	Ingo
