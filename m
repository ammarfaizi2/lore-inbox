Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUCaHPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUCaHPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 02:15:07 -0500
Received: from piedra.unizar.es ([155.210.11.65]:11743 "EHLO relay.unizar.es")
	by vger.kernel.org with ESMTP id S261786AbUCaHPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 02:15:02 -0500
In-Reply-To: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
References: <200403262054.i2QKsV223748@rda07.lmcg.wisc.edu>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1CB30982-82E3-11D8-A22A-000A9585C204@able.es>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Somewhat OT: gcc, x86, -ffast-math, and Linux
Date: Wed, 31 Mar 2004 09:14:55 +0200
To: Daniel Forrest <forrest@lmcg.wisc.edu>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26 mar 2004, at 21:54, Daniel Forrest wrote:

> different machines.  However, the differences are all less than the
> precision of a single-precision floating point number.  By this I mean
> that if the results (which are written to 15 digits of precision) are
> only compared to 7 digits then the results are the same.  Also, most
> of the time the 15 digit values are the same.
>

(sorry if this is stupid, but anyways...)

Don't blame fast-math, if I undestood what you did...
With single-precission floats, you just have 7 digits of precission
(scientific notation) [1].
If you ask printf() to write 15 decimal places, it just _lies_.
How does it invent the rest of decimals, is up to glibc. Just
get glibc sources.

In short, anything past the 7th digit is crap, and can be different
depending on the box, cosmic rays and a butterfly waving its wings.

[1] cpp -dM /dev/null | grep EPSILON
     cpp -dM /dev/null | grep FLT


--
J.A. Magallon <jamagallon()able!es>   \          Software is like sex:
werewolf!able!es                       \    It's better when it's free
MacOS X 10.3.3, Build 7F44, Darwin Kernel Version 7.3.0

