Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUGJXw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUGJXw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 19:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUGJXw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 19:52:58 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:7228 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266460AbUGJXw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 19:52:56 -0400
Date: Sat, 10 Jul 2004 16:52:07 -0700
From: Paul Jackson <pj@sgi.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-Id: <20040710165207.477efad6.pj@sgi.com>
In-Reply-To: <40EFB775.8020408@eyal.emu.id.au>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	<m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	<40EFB775.8020408@eyal.emu.id.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(off-topic alert)

>	if (0 != i)

Does anyone know of the origins of writing such tests this way, rather
than:

	if (i != 0)

I read the first as testing whether "0" has a certain property, which is
a silly thing to test, since the properties of "0" are rather constant.

The second form I read as testing a property of "i" - much more
interesting.  Logically, the same, of course.  Just a question of which
form is more idiomatic.

Back in the days when it was Ken, Dennis and Brian, not K & R, I don't
recall seeing the first form used much.  Even now I see _zero_ matches
on "if (0 " in kernel or mm - only in arch, drivers, net, scripts, and
sound (with a single time.h exception).

If I were Linus, I'd vote the first form off the island.  Then again,
if I were Linus, you would never have heard of Linux ;).

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
