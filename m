Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267043AbRH0Toh>; Mon, 27 Aug 2001 15:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267009AbRH0To3>; Mon, 27 Aug 2001 15:44:29 -0400
Received: from mclean.mail.mindspring.net ([207.69.200.57]:27923 "EHLO
	mclean.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S267140AbRH0Tnk>; Mon, 27 Aug 2001 15:43:40 -0400
Subject: Re: Updated Linux kernel preemption patches
From: Robert Love <rml@tech9.net>
To: J Sloan <jjs@toyota.com>
Cc: Cliff Albert <cliff@oisec.net>,
        Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3B8AA02D.6F7561AB@lexus.com>
In-Reply-To: <998877465.801.19.camel@phantasy>
	<20010827093835.A15153@oisec.net>  <3B8AA02D.6F7561AB@lexus.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.21.23.41 (Preview Release)
Date: 27 Aug 2001 15:44:21 -0400
Message-Id: <998941465.1993.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-08-27 at 15:31, J Sloan wrote:
> I get the same error -
> 
> RH 7.1 + updates and bits of rawhide -

I am looking into this, but I do not have this problem (which is odd).

The patch wraps one define of atomic_dec_and_lock in an #ifndef
CONFIG_PREEMPT, but I assume there is another defination elsewhere.  For
whatever reason, my kernel compiles fine.

I am going to update the patch to 2.4.9-ac2, give that a try.

Wait a second...you are _ENABLING_ the configure option, right?  Always
run `make oldconfig' !!!  If you are not, in this case, the patch is
breaking compiles where CONFIG_PREEMPT is not set...now I can fix that.
Please let me know.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

