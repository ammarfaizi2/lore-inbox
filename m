Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266472AbUGKAOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266472AbUGKAOC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 20:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUGKAOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 20:14:02 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:58523 "EHLO
	tp-timw.internal.splhi.com") by vger.kernel.org with ESMTP
	id S266463AbUGKAN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 20:13:59 -0400
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
From: Tim Wright <timw@splhi.com>
Reply-To: timw@splhi.com
To: Paul Jackson <pj@sgi.com>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20040710165207.477efad6.pj@sgi.com>
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org>
	 <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
	 <40EFB775.8020408@eyal.emu.id.au>  <20040710165207.477efad6.pj@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1089504763.1473.28.camel@tp-timw.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 10 Jul 2004 17:12:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It was because

if (0 = i)

will give an error where you obviously meant '=='. It prevents
accidental "assignment in conditional context".

Tim

On Sat, 2004-07-10 at 16:52, Paul Jackson wrote:
> (off-topic alert)
> 
> >	if (0 != i)
> 
> Does anyone know of the origins of writing such tests this way, rather
> than:
> 
> 	if (i != 0)
> 
> I read the first as testing whether "0" has a certain property, which is
> a silly thing to test, since the properties of "0" are rather constant.
> 
> The second form I read as testing a property of "i" - much more
> interesting.  Logically, the same, of course.  Just a question of which
> form is more idiomatic.
> 
> Back in the days when it was Ken, Dennis and Brian, not K & R, I don't
> recall seeing the first form used much.  Even now I see _zero_ matches
> on "if (0 " in kernel or mm - only in arch, drivers, net, scripts, and
> sound (with a single time.h exception).
> 
> If I were Linus, I'd vote the first form off the island.  Then again,
> if I were Linus, you would never have heard of Linux ;).
