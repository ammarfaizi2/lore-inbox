Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbUCBPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbUCBPA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:00:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:30853 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261664AbUCBPAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:00:25 -0500
Date: Tue, 2 Mar 2004 10:02:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "James H. Cloos Jr." <cloos@jhcloos.com>
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
In-Reply-To: <m3u1175miy.fsf@lugabout.jhcloos.org>
Message-ID: <Pine.LNX.4.53.0403021000250.19478@chaos>
References: <20040301184512.GA21285@hobbes.itsari.int> <c2175f$6hn$1@terminus.zytor.com>
 <m3u1175miy.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, James H. Cloos Jr. wrote:

> >>>>> "Peter" == H Peter Anvin <hpa@zytor.com> writes:
>
> Peter> As RBJ said, ptys are now recycled in pid-like fashion, which
> Peter> means numbers won't be reused until wraparound happens.
>
> Ouch.  I've been using the tty name in $HISTFILE for some time now
> (at least on laptops and workstations); I do not see any reasonable
> alternative to prevent overwriting while still saving history.
>
> Will patching in the old behavior wrt re-use, while not disrupting
> the other improvements, be a lot of work?  I've looked thru the src,
> but haven't yet spotted the point where the new pis number is chosen.
>
> -JimC
>

I think /dev/tty, used in the context of any process, always refers
to the current processes terminal. You should not have to "hard-code"
a particular terminal.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


