Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWB1Tqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWB1Tqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWB1Tqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:46:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46050 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932530AbWB1Tq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:46:29 -0500
Date: Tue, 28 Feb 2006 20:45:03 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rt] buggy UART fix
Message-ID: <20060228194503.GB23453@elte.hu>
References: <Pine.LNX.4.58.0602270954520.26564@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602270954520.26564@gandalf.stny.rr.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Ingo,
> 
> I'm not sure if this is the correct fix, but it fixes a problem on one 
> of our boards.  The uart does't set the IIR register upon receiving an 
> interrupt for transmit.  Thus we get processes stuck waiting to send 
> data out.
> 
> This doesn't seem to be a problem on vanilla, and I'm not sure why. 
> Perhaps the scheduling doesn't ever let the transmit buffer get full? 
> Well I haven't look too much into the vanilla side.
> 
> This patch forces the processing of the interrupt even if the iir 
> doesn't show that there was an interrupt, iff the uart has been 
> detected as buggy (which our board's uart is ) and the interrupt 
> hasn't already handled it.

thx, applied.

	Ingo
