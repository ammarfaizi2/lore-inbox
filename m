Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbUACWee (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUACWee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:34:34 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:26003 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263788AbUACWeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:34:31 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
References: <bsgav5$4qh$1@cesium.transmeta.com>
	<Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
	<3FF5E952.70308@tmr.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 03 Jan 2004 22:11:36 +0100
In-Reply-To: <3FF5E952.70308@tmr.com> (Bill Davidsen's message of "Fri, 02
 Jan 2004 16:57:38 -0500")
Message-ID: <m365fsu48n.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> I would probably write
>    ( a ? b : c ) = d;
> instead, having learned C when some compilers parsed ? wrong without
> parens. Actually I can't imagine writing that at all, but at least
> with parens humans can read it easily. Ugly code.
>
> Your suggestion is not portable, if b or c are declared "register"
> there are compilers which will not allow taking the address, and gcc
> will give you a warning.

One can write as well:

if (a)
        b = d;
else
        c = d;

Might be more readable and it is what the compiler does.
-- 
Krzysztof Halasa, B*FH
