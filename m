Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSBDWiP>; Mon, 4 Feb 2002 17:38:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289240AbSBDWiD>; Mon, 4 Feb 2002 17:38:03 -0500
Received: from [209.237.59.50] ([209.237.59.50]:22690 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S289236AbSBDWhk>; Mon, 4 Feb 2002 17:37:40 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
In-Reply-To: <Pine.LNX.3.96.1020204171035.31056A-100000@gatekeeper.tmr.com>
From: Roland Dreier <roland@topspincom.com>
Date: 04 Feb 2002 14:37:34 -0800
In-Reply-To: Bill Davidsen's message of "Mon, 4 Feb 2002 17:13:44 -0500 (EST)"
Message-ID: <52n0yolvpt.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bill" == Bill Davidsen <davidsen@tmr.com> writes:

    Bill> Why would the kernel NOT use available source of entropy? If
    Bill> the kernel is gathering entropy, in what way is user mode
    Bill> better? Are you going to make users install disk, keystroke,
    Bill> packet, etc daemons to do the work of the kernel?

Entropy is gathered from interrupt timing in the kernel because
interrupts are handled in the kernel.  It would be quite difficult for
a user space process to get accurate information about interrupt
timing.

However, the i8xx RNG and audio entropy daemons work perfectly well
from user space.  What is gained by moving that code into the kernel?

Best,
  Roland
