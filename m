Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUCMUqO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUCMUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 15:46:14 -0500
Received: from zero.aec.at ([193.170.194.10]:54790 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261205AbUCMUqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 15:46:13 -0500
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kref, a tiny, sane, reference count object
References: <1zhdz-5uL-3@gated-at.bofh.it> <1zhdz-5uL-1@gated-at.bofh.it>
	<1zm3F-2ex-7@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 13 Mar 2004 21:43:09 +0100
In-Reply-To: <1zm3F-2ex-7@gated-at.bofh.it> (Greg KH's message of "Sat, 13
 Mar 2004 19:30:11 +0100")
Message-ID: <m3d67gscki.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> But people do get it wrong (I've seen it happen).  Using this keeps you

If they cannot get a simple reference counter right it is doubtful
the rest of their code will do any good.

> from having to write your own get, and put functions.  Multiply that by
> every usb driver that wants to (and needs to) use this kind of logic,
> and you have a lot of duplicated code that is unnecessary.

Lots of duplicated one liners. Sounds like a big issue.
For me this thing smells more like overabstraction.

> So we write it once, get it correct, and let everyone use it.  Isn't
> that what the code in /lib is for?  :)

I would agree if it is significant code. But all you're replacing is a
few straight forward one/two liners, and that at the cost of less
efficient space usage (12 byte overhead on 64bit)

-Andi

