Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268381AbTAMWbQ>; Mon, 13 Jan 2003 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268371AbTAMW31>; Mon, 13 Jan 2003 17:29:27 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:59404 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S268381AbTAMW25>;
	Mon, 13 Jan 2003 17:28:57 -0500
Date: Mon, 13 Jan 2003 17:37:48 -0500 (EST)
Message-Id: <200301132237.h0DMbm1328427@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.kernel.org
Cc: matti.aarnio@zmailer.org
Subject: Re: any chance of 2.6.0-test*?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matti Aarnio writes:

> Advanced optimizer hinting features, like unlikely() attribute
> are very new in (this) compiler, and while they in theory move the
> "unlikely" codes out of the fast-path, such things have been buggy
> in the past, and we are worried of bug effects... 

I've been wondering about this as the goto-thread spewed by.

As I recall, gcc recently started moving basic blocks around.
This destroyed most of the careful goto-based optimizations.
Now we're supposed to use likely() and unlikely() instead.

Hmmm?

BTW, what I'd like is a way to change optimization settings
on a per-function or even per-block basis. Telling gcc to
unroll a specific loop or pack a function into a tiny space
would be really cool.   __attribute__((__opt__("-Os")))
I could go for an "assume default case can't happen" too.
