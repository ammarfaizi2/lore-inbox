Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTJGUr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbTJGUr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 16:47:27 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:58080 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262864AbTJGUrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 16:47:24 -0400
Message-ID: <20031007204720.25379.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 07 Oct 2003 15:47:20 -0500
Subject: Re: Circular Convolution scheduler
X-Originating-Ip: 172.131.225.53
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note: the point of my question was not to belittle
the current work on scheduler heuristics to get better interactive usability on workstations.

Here is what the development process for the scheduler over the last couple of years looks
like to me: we start with a fair scheduler,
bias it for processes that always have work to do when they are scheduled, then poke around at it
with heuristics to try mitigate the starvation of interactive processes that resulted from favoring "always have work to do" batch processes in the
initial design.

This seems a bit like reverse-engineering code
that we wrote ourselves to begin with.

Ingo's idea of making scheduling itself faster
regardless of assigned priorities is a good plan,
but it is not really relevant to my question,
which is what sort of priority adjustment algorithm would take interactive (or batch) priority
adjustment code tweaks out of the realm of
guesswork.

Right now we seem to be writing new code without
knowing what effect it will have on batch-interactive
scheduling until after a lot of testing, because
the code is too complex to predict the effect
of changes beforehand. This seems like doing
things the hard way, with lots of detours.

Is interactive performance acceptable with a
completely fair scheduler that does not adjust
priorities based on runtime behavior? (Ie could
we possibly fix this in simpler fashion not
by special-casing interactivity but rather by
un-special-casing something else, maybe adjustable
with a /proc value, sysctl() call, etc.)

I'm also reminded of "compile for network router"
in earlier kernel configs.

"Compile as workstation? [Y]  "

(Not very intuitive. Everyone that didn't read
Configure.help wouldn't be able to guess what
the difference would be between Yes and No answers
to that question. But that's a pretty simple
way to put it.)

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

-- 
__________________________________________________________
Sign-up for your own personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

