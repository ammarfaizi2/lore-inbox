Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131331AbRCSBy1>; Sun, 18 Mar 2001 20:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131335AbRCSByH>; Sun, 18 Mar 2001 20:54:07 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:49341 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S131331AbRCSByC>;
	Sun, 18 Mar 2001 20:54:02 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103190153.RAA23378@csl.Stanford.EDU>
Subject: Re: [CHECKER] 28 potential interrupt errors
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sun, 18 Mar 2001 17:53:10 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
In-Reply-To: <3AB4A162.17FD434A@mandrakesoft.com> from "Jeff Garzik" at Mar 18, 2001 06:52:02 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Request:  can the checker check for skb's being freed correctly?  The
> rules:
> 
> If an skb is in interrupt context, call dev_kfree_skb_irq.
> If an skb might be in interrupt context, call dev_kfree_skb_any.
> If an skb is not in interrupt context, call dev_kfree_skb.

It shouldn't be hard to check this.  The only thing interesting will be
deriving when you're in an interrupt context.  Thanks for the pointer.
Are there other context-sensitive rules that we could go after as well?

> I dunno WTF the programmer was thinking here...  Your de-ref checker
> should have caught this too:  check 'lp' for NULL after de-referencing
> lp->lock.

These reports are for an older version of the checker --- we've fixed
some bugs in the system, which should catch more of these errors.

Dawson
