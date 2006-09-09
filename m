Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWIICf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWIICf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWIICf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:35:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:44181 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750984AbWIICfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:35:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] proc: Make the generation of the self symlink table driven.
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<20060907101512.3e3a9604.akpm@osdl.org>
	<Pine.LNX.4.61.0609080906380.22545@yvahk01.tjqt.qr>
	<m11wqmmxfw.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0609081507330.20566@yvahk01.tjqt.qr>
	<m1fyf2lc91.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0609081851260.19699@yvahk01.tjqt.qr>
Date: Fri, 08 Sep 2006 20:34:31 -0600
In-Reply-To: <Pine.LNX.4.61.0609081851260.19699@yvahk01.tjqt.qr> (Jan
	Engelhardt's message of "Fri, 8 Sep 2006 18:55:10 +0200 (MEST)")
Message-ID: <m1d5a5kbt4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>Regardless this isn't a case where the C precedence is wrong.
>>"a < b | 1" is an example of C getting the precedence wrong.
>
> Blame the creator of C.
> But maybe this was intended, since | is a logical operation, as is <, 
> while + is an arithmetic one. Programmatically probably not making much 
> sense, bitfield |= a < b is one use case.

I do.  As I recall the history | and & predate the introduction
of || and && and originally served both functions, so the got
the lower precedence.

>>Having to remember where C is wrong and in what circumstances is
>>harder than just putting in parenthesis.
>
> The GNU C compiler will warn you where such may happen, but
> currently does so - too bad - only with && and ||.
>  c.c:2: warning: suggest parentheses around && within ||

You see my point :)  I have better things to worry about
when writing and reviewing code than remember what the
precedence rules are.

Anyway I have figured out how to remove the need for the - 1,
and the trailing empty entries in proc, patch to follow shortly.

Eric




