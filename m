Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTEMBb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 21:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTEMBb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 21:31:27 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:5528 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263096AbTEMBb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 21:31:26 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new kconfig goodies
References: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 13 May 2003 10:44:01 +0900
In-Reply-To: <Pine.LNX.4.44.0305111838300.14274-100000@serv>
Message-ID: <buou1bz7h9a.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> writes:
> BTW this clears my todo list of important features for the kconfig syntax 
> itself, if you think there is something missing, please tell me now, 
> otherwise it might have to wait for 2.7.

Hi, I sent the following about kconfig a while ago, but never got an
answer; do you have any comment on it?

Here's the message:

> I have the following two entries in my Kconfig file (arch/v850/Kconfig):
>
>    config RTE_CB_MULTI
>    	  bool
> 	  # RTE_CB_NB85E can either have multi ROM support or not, but
> 	  # other platforms (currently only RTE_CB_MA1) require it.
> 	  prompt "Multi monitor ROM support" if RTE_CB_NB85E
> 	  depends RTE_CB
> 	  default y
>
>    config RTE_CB_MULTI_DBTRAP
>    	  bool "Pass illegal insn trap / dbtrap to kernel"
> 	  depends RTE_CB_MULTI
> 	  default n
>
> What I expect this to do is to only ask the first question (RTE_CB_MULTI)
> if RTE_CB_NB85E is true and otherwise just assume true -- this part
> seems to work correctly -- but to _always_ ask the second question
> (RTE_CB_MULTI_DBTRAP) as long as its dependencies are true.
>
> However, what happens in practice is that the second question is only
> displayed if the first question is displayed (the resulting actual value
> of RTE_CB_MULTI_DBTRAP is whatever value it had before I entered the
> menuconfig).
>
> So... is this a bug?  If not, is there some other way I can have a
> question [a] depend on another question [b], where [b] is optional
> (defaulting to y), but [a] is not?

[I haven't tested this recently, so I suppose it could have silently
been fixed.]

Thanks,

-Miles
-- 
Would you like fries with that?
