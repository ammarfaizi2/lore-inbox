Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292267AbSBBLYP>; Sat, 2 Feb 2002 06:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292268AbSBBLX4>; Sat, 2 Feb 2002 06:23:56 -0500
Received: from gold.MUSKOKA.COM ([216.123.107.5]:10764 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S292267AbSBBLXw>;
	Sat, 2 Feb 2002 06:23:52 -0500
Message-ID: <3C5BC961.6282BB7F@yahoo.com>
Date: Sat, 02 Feb 2002 06:11:29 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clipped disk reports clipped lba size
In-Reply-To: <UTC200202012155.VAA123193.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     From: Paul Gortmaker <p_gortmaker@yahoo.com>
>
>     Alan has said (quite reasonably) that he is not interested in inclusion
>     of the big IDE patch that exists for 2.2.x -- however, a minimal cut and
>     paste backport from 2.4.x IDE to just support HDIO_DRIVE_CMD_AEB (and thus
>     support setmax) is only about a 100 line diff which I did a while ago.
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>     If there is any interest in this I can check it still applies cleanly to
>     current 2.2 pre kernel and send it along for inclusion.
> 
> (1) *_AEB is intended as private namespace for me, not for inclusion
> in an official kernel. So, some official name, like HDIO_DRIVE_TASK,
> must be better.

Yes, DRIVE_TASK is of course the official name - I just knew you would
immediately recognize *_AEB  & and know context/usage :)   BTW, if you
didn't want it in an official kernel, it is a bit late for that. It has
been in for some time in 2.4 .... <grep>  2.3.99pre9 to be exact.

> Both problems can be solved with relatively small patches,
> no big monolithic IDE patch required. And I would prefer

Please see above - I agree, and was suggesting a small patch to 2.2 
rather than the massive one (which Alan already ruled out months ago).

> to solve both problems without involving ioctl's, or boot
> parameters, or config parameters. All should just work
> in the common case.

This is a valid point - in an ideal situation things should just work
without user intervention or setmax util, etc.  What are you currently
recommending to 2.2.x kernel users that come across this limitation
prior to such an ideal fix being released in a 2.2.x kernel?

Paul.

